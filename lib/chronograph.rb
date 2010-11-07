require 'date'
require 'chronograph/event'
require 'chronograph/person'
require 'chronograph/dsl'


module Chronograph
	class Timeline
        include Enumerable

		def initialize(&block)
			@people = []
			@events = []

            t = EventDSL.new
			t.instance_eval(&block)

            @people << t.people
            @events << t.events
		end

        def each(&block)
            consolidate.each(&block)
        end

		def event(name, date, desc)
			@events << Event.new(name, date, desc)
		end
		
		def today
			event "Today", Date.today, "this day"
		end

		def consolidate
			t = []
			t << @events << @people.flatten.map { |x| x.events }
			return t.flatten.sort { |a, b| a.date <=> b.date }
		end
		
		def get_text
			consolidate.map { |x| "#{x.date}: #{x.name}, #{x.desc}" }.join("\n")
		end

		def get_html_table
            warn "Warning, get_html_table has not tested"
			r = "<table>"
			consolidate.each do |x|
				r += "<tr>"
				r += [x.date, x.name, x.desc].map { |x| "<td>" + x.to_s + "</td>"}.join
				r += "</tr>"
			end
			r += "</table>"
		end
	end
end


if $0 == __FILE__
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

    #t.each { |x| puts x.inspect }
#    puts t.get_html_table
	puts t.get_text
end
