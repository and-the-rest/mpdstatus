mpdstatus
=========

A small Sinatra frontend for viewing the queue and other statistics for an
MPD instance.

## Usage

### Installation

```bash
$ git clone https://github.com/and-the-rest/mpdstatus.git
$ cd mpdstatus
$ bundle install --path vendor/bundle
```

### Running

```bash
$ vim config.yml # change the host and port, if necessary
$ ruby app.rb # takes normal sinatra arguments
```
