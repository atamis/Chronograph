require "test/unit"
require "chronograph/event"

module Chronograph
    class TestChronograph < Test::Unit::TestCase
        def test_parse_date
            assert_equal(Date.today, parse_date(Date.today))
            assert_equal(Date.new(2010), parse_date(2010))
        end

        def test_errors
            assert_raise(TypeError) { Event.new(nil, nil, nil)  }
        end

        def test_recall
            name = :test
            date = Date.today
            desc = "cool"
            e = Event.new(name, date, desc)
            assert_equal(name, e.name)
            assert_equal(date, e.date)
            assert_equal(desc, e.desc)
        end
        # And that's all she wrote, folks. There isn't much else to test.
    end
end
