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
        # List all events
        @events = Event.all
        @events.to_json
    end

    delete '/events' do
        p "Delete all events"
    end

    get '/events/:id' do
        # Show event with :id
        @event = Event.find_by_id(params[:id])
        @event.to_json
    end

    put '/events/:id' do
        p "Update event :id"
    end

    delete '/events/:id' do
        p "Delete event :id"
    end
end