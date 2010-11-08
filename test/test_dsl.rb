require "test/unit"
require "chronograph"

module Chronograph
    class TestDSL < Test::Unit::TestCase
      def test_sanity
          assert_nothing_raised(Exception) { t = EventDSL.new }
      end

      def test_event
          name, date, desc = "test", Date.today, "test_cool"
          t = EventDSL.new
          t.event name, date, desc
          x = t.events[0]
          assert(x.is_a?(Event), "Oh dear, the event wasn't an event!")
      end

     def test_person
         t = EventDSL.new
         t.person "test", Date.today-10, Date.today, "a good man" do ||
             event "test event", Date.today-5, "test event"
         end
         p = t.people[0]
         assert(p.is_a?(Person), "Oh god, the person wasn't a person!")
         # Later, we could add more for long_event or war
     end
    end
end
