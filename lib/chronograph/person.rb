module Chronograph
    class Person < Struct.new(:name, :birth, :death, :desc, :events)
        attr_reader :name, :birth, :death, :desc
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
            Event.new("Birth of #{name}", birth, "#{name} is born. #{@desc}")
        end

        def ending_event
             Event.new("Death of #{name}", death, "#{name} dies. #{@desc}")
        end


    end

    class LongEvent < Person
        def begining_event                               
            Event.new("Beginning of #{name}", birth, "#{name} begins. #{@desc}")
        end

        def ending_event
            Event.new("End of #{name}", death, "#{name} ends. #{@desc}")
        end
    end

    
    class War < LongEvent; end
end
