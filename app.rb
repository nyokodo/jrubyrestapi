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

require 'sinatra/activerecord'
require 'model/event'
require 'appbase'


class EventApp < AppBase
    # This Class defines all the REST Requests
    
    post '/events' do
        # Add a new event.
        event = Event.create(data: @data['data'])
        
        if event.persisted?
            # Return the Location Header for the newly created event.
            headers "Location" => "#{request.url}/#{event.id}"
            return build_response('ok', 'Event created.')
        else
            status 500
            return build_response('error', event.errors.messages)
        end
    end

    get '/events/?' do
        # Returns a list of all events in the database.
        if Event.exists?
            events = Event.all
            return events.to_json
        else
            # There are no events so return an empty array
            return Array.new.to_json
        end
    end

    delete '/events' do
        # Delete all events.
        if Event.exists?
            Event.destroy_all
            return build_response('ok', 'All events deleted.')
        else
            status 404
            return build_response('error', 'No events exist.')
        end
    end

    get '/events/:id' do
        # Return a particular event identified by :id
        event = Event.find_by_id(params[:id])
        
        if !event.nil?
            return event.to_json
        else
    end

    put '/events/:id' do
        # Update an existing event.
        event = Event.find_by_id(params[:id])
        
        if !event.nil?
            event.data = @data['data']
            event.save
            
            if event.valid? and event.persisted?
                return build_response('ok', 'Event has been updated.')
            else
                status 500
                return build_response('error', event.errors.messages)
            end
        else
    end

    delete '/events/:id' do
        # Delete event identified by :id
        event = Event.find_by_id(params[:id])
        
        if !event.nil?
            event.destroy
            return build_response('ok', 'Event has been deleted.')
        else
    end
end