# Simple JRuby REST API

This is a simple REST API developed in JRuby as an example of my work.

## Setup Instructions

1. Install JRuby 1.7.16:
    http://jruby.org/getting-started
2. Install Bundler by running following:
    jruby -S gem install bundler
3. Run Bundler to install project dependencies:
    jruby -S bundle install
4. Create database:
    jruby -S rake db:setup

## Run Instructions

* To start the server run: jruby -S rackup -o localhost -p 8999