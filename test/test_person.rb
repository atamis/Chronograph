require "test/unit"
require "chronograph/person"

module Chronograph
    class TestPeson < Test::Unit::TestCase
        def setup
            @t = nil
            assert_nothing_raised(Exception) do
                @t = Person.new("test", Date.today, Date.today+10, "this was awesome", Event.new("test event", Date.today+5, "test event"))
            end
        end
       
        def test_begining_event
           b = @t.begining_event 
           assert(b.is_a?(Event), "The begining event is not an event!")

           e = @t.ending_event
           assert(e.is_a?(Event), "The ending event is not an event!")
        end

        def test_recall
            name = "test"
            begining = Date.new(2000)
            ending = Date.new(2010)
            desc = "this is awesome"
            event = Event.new("test", Date.new(2005), "awesome")

            x = Person.new(name, begining, ending, desc, event)
            assert_equal(name, x.name)
            assert_equal(begining, x.birth)
            assert_equal(ending, x.death)
        end

    end
end
