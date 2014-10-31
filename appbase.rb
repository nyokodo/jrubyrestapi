#!/usr/bin/env ruby

require 'sinatra'

configure { set :server, :puma } 

class AppBase < Sinatra::Base
    # This Class defines the scaffolding for the REST Calls. Parsing the request body,
    # closing connections when done and handling exceptions.
    # This was can be used by multiple Sinatra/Puma REST APIs

    before do
        # Set the content_type for all requests to JSON and parse data for POST/PUT
        content_type :json
        status 200
        method = request.request_method
        if method == 'POST' or method == 'PUT'
            @data = JSON.parse request.body.read
        end
    end
    
    after do
        # ActiveRecord is nice enough to implicitly open a connection but
        # it does not implicitly relinquish them in this case.
        close_connections
    end
    
    not_found do
        # Called when a URI is requested that doesn't exist.
        status 404
        type = 'error'
        message = 'InvalidUri: The requested URI does not exist on the server.'
        build_response(type, message)
    end
    
    error do
        # Called when an exception occurs in a route or filter.
        close_connections
        status 500
        type = 'error'
        message = env['sinatra.error'].name
        build_response(type, message)
    end
    
    def build_response(type, message)
        response = {'type' => type, 'message' => message }
        response.to_json
    end
    
    def close_connections
        # Close all connections held by this thread.
        ActiveRecord::Base.clear_active_connections!
    end
end