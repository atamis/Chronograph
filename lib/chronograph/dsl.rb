require 'chronograph/event'
require 'chronograph/person'

module Chronograph
    class EventDSL
        attr_accessor :events, :people
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
end
