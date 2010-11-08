libdir = File.dirname(__FILE__)
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)


require 'date'
require 'chronograph/event'
require 'chronograph/person'
require 'chronograph/dsl'


module Chronograph
    VERSION = "0.0.1"
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

