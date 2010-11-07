require 'date'

module Chronograph

    class EventDSL
        attr_reader :events, :people
        def initialize()
            @events = []
            @people = []
        end


        def event(name, date, desc)
            date = parse_date date
            @events << Event.new(name, date, desc)
        end
    
        def today
            event "Today", Date.today, "this day"
        end
    
        def person(name, birth, death, desc, &block)
            birth = parse_date birth
            death = parse_date death
            t = EventDSL.new
            t.instance_eval(&block) if block != nil
            
            @people << Person.new(name, birth, death, desc, *(t.events + t.people.map { |x| x.events })) # TODO: this sort of combines the events and the people. Problem?
        end

        def long_event(name, birth, death, desc, &block)
            birth = parse_date birth
            death = parse_date death
            t = EventDSL.new
            t.instance_eval(&block) if block != nil

            @people << LongEvent.new(name, birth, death, desc, *(t.events + t.people.map { |x| x.events }))
        end

        def war(name, birth, death, desc, &block)
            birth = parse_date birth
            death = parse_date death
            t = EventDSL.new
            t.instance_eval(&block) if block != nil

            @people << War.new(name, birth, death, desc, *(t.events + t.people.map { |x| x.events }))
        end

        def parse_date x
            x.is_a?(Integer) ? Date.new(x) : x
        end
    end

    class Event < Struct.new(:name, :date, :desc)
        attr_accessor :name, :date, :desc
        def initialize(name, date, desc)
            raise TypeError.new("date must be a date") unless date.is_a? Date
            raise TypeError.new("name has to be a name or symbol") unless name.is_a?(String) || name.is_a?(Symbol)
            raise TypeError.new("desc must be a string") unless desc.is_a? String

            @name = name
            @date = date
            @desc = desc
        end
        
    end




    class Person < Struct.new(:name, :birth, :death, :desc, :events)
        attr_reader :name, :birth, :death, :desc, :events
        def initialize(name, birth, death, desc, *events)
            raise TypeError.new("name has to be a name or symbol") unless name.is_a?(String) || name.is_a?(Symbol)
            raise TypeError.new("birth and death must be a date") unless birth.is_a?(Date) && death.is_a?(Date)
            
            raise TypeError.new("desc must be a string") unless desc.is_a? String
            
            @name = name
            @birth = birth
            @death = death
            @desc = desc
            @events = events
        end
        
        def events
            [begining_event, ending_event, @events].flatten
        end

        def begining_event
            Event.new("Birth of #{name}", birth, "#{name} is born")
        end

        def ending_event
             Event.new("Death of #{name}", death, "#{name} dies")
        end


    end

    class LongEvent < Person
        def begining_event                               
            Event.new("Beginning of #{name}", birth, "#{name} begins")
        end

        def ending_event
            Event.new("End of #{name}", death, "#{name} ends")
        end
    end

    
    class War < LongEvent; end

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
