#!/usr/bin/ruby
# Sorry to java lovers. Interestingly, I like java, but I needed a subject
# matter, and the French revolution didn't seem like a good one.

require 'rubygems'
require 'chronograph' # This is the all important line

t = Chronograph::Timeline.new do

    # Groups affect html tags, but not, as of now, affect plain text
    group :ruby do
        # Group related events and people together. Whenever you recurse
        # like this, you get the same DSL. Note that while this looks
        # recursive, the recursivity of the data is not saved.
        person "Mr. Ruby", 1654, 2010, "He was awesome" do
            # This event could be here, it could be in the
            # root of the block, or in one further in. It 
            # doesn't matter
            event "Mr. Ruby leaves Japan", 2000, "It was easy"

            # People, long_events, and wars are handled in 
            # essentially the same way, but with different
            # wording for the start and end events.
            war "War against Java", 2005, 2007, "It was needed" do

                # When you need a more precise date, you can use the default
                # constructor. When you just need a year, just use the year.
                # In this case, you could just use 2005, though it will show up
                # as January 1st of 2005.
                event "Battle of the MRI", Date.new(2005, 5, 6), "Mr. Ruby almost lost"
                # These events get added to the general event list. All events
                # do regardless of where they are defined. Niether location nor
                # order of the definition matters.
                event "Battle of the JVM", Date.new(2005, 10, 31), "This was one scary halloween for Javaland"
            end
        end
    end
                        
    group :java do
        # This is the stupid and redundant way of doing things.
        # Can you guess how we could improve this?
        event "Javaland founded", Date.new(1990), "1000s die"

        event "Clojure", 2000, "people are intrigued"

    end
                                
                                
    # This represents today.
    today
end

# This first prints out the html table, and then the plain text version
puts t.get_html_table
puts t.get_text

