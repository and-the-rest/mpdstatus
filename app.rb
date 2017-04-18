#!/usr/bin/env ruby

require "sinatra"
require "haml"
require "ruby-mpd"
require "json"
require "yaml"

DEFAULTS = {
  "host" => "localhost",
  "port" => 6600,
}

CONF = DEFAULTS.merge(YAML.load_file("config.yml"))

def mpd_status
  mpd = MPD.new CONF["host"], CONF["port"]
  mpd.connect

  status = {}
  status[:np] = mpd.playing? ? "#{mpd.current_song.artist} - #{mpd.current_song.title}" : "Nothing currently playing!"
  status[:status] = mpd.status
  active_queue = mpd.queue[mpd.status[:nextsong]..-1]
  status[:queue] = active_queue.map { |s| "#{s.artist} - #{s.title}" }
  status[:stats] = mpd.stats

  status
ensure
  mpd.disconnect
end

get "/" do
  status = mpd_status
  haml :index, locals: { status: status }
end

get "/json" do
  content_type :json
  mpd_status.to_json
end

not_found do
  haml :error, locals: { error: "404" }
end
