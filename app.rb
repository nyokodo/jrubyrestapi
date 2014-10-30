#!/usr/bin/env ruby

require 'sinatra'
require 'sinatra/activerecord'

configure { set :server, :puma }

class Event < ActiveRecord::Base
end

class EventApp < Sinatra::Base
    before do
        content_type :json
    end
    
    post '/events' do
        p "Make new event"
    end

    get '/events/?' do
        p "List all events"
    end

    delete '/events' do
        p "Delete all events"
    end

    get '/events/:id' do
        p "Show event :id"
    end

    put '/events/:id' do
        p "Update event :id"
    end

    delete '/events/:id' do
        p "Delete event :id"
    end
end