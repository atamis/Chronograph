#!/usr/bin/ruby

require 'rubygems'
require 'chronograph'

t = Chronograph::Timeline.new do
    person "Mr. Ruby", 1654, 2010, "He was awesome" do
        event "Mr. Ruby leaves Japan", 2000, "It was easy"

        war "War against Java", 2005, 2007, "It was needed" do
            event "Battle of the MRI", Date.new(2005, 5, 6), "Mr. Ruby almost lost"
            event "Battle of the JVM", Date.new(2005, 10, 31), "This was one scary halloween for Javaland"
        end
    end
                        
    event "Javaland founded", Date.new(1990), "1000s die"
                                
                                
    today
end

puts t.get_html_table
puts t.get_text

