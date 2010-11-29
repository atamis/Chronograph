
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

        def add &block
            t = EventDSL.new
            t.instance_eval(&block)
            @people << t.people
            @event << t.events
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
#            warn "Warning, get_html_table has not tested"
			r = "<table>"
			consolidate.each do |x|
                r += x.to_table_html
			end
			r += "</table>"
		end
	end
end
