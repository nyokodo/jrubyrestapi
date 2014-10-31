#!/usr/bin/env ruby
# This is a simple REST API for events created as a programming task.
# Data is accepted and transmitted as JSON.
#
# Events are defined by a name and latitude/longitude coordinate in
# a JSON property called 'data.' They are inserted with a unique id
# and individually accessed via that id.
#
# A real API should have a security mechanism like OAuth and force the use
# of https.
#

require 'sinatra'
require 'sinatra/activerecord'
require 'model/event'

configure { set :server, :puma }

class EventApp < Sinatra::Base
    before do
        # This is executed before the individual requests
        content_type :json
        method = request.request_method
        if method == 'POST' or method == 'PUT'
            @data = JSON.parse request.body.read
        end
    end
    
    post '/events' do
        # Add a new event.
        Event.create(data: @data['data'])
    end

    get '/events/?' do
        # Returns a list of all events in the database.
        events = Event.all
        events.to_json
    end

    delete '/events' do
        # Delete all events.
        Event.destroy_all
    end

    get '/events/:id' do
        # Return a particular event identified by :id
        event = Event.find_by_id(params[:id])
        event.to_json
    end

    put '/events/:id' do
        # Update an existing event.
        event = Event.find_by_id(params[:id])
        event.data = @data['data']
        event.save
    end

    delete '/events/:id' do
        # Delete event identified by :id
        event = Event.find_by_id(params[:id])
        event.destroy
    end
end