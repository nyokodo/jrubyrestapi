#!/usr/bin/env ruby

class Event < ActiveRecord::Base
    # This is the ActiveRecord representation of the events schema in the database.
    # This could use some more validations for the form of data.
    
    validates_length_of :data, :minimum => 15
end