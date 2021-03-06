require "test/unit"
require "chronograph/timeline"

module Chronograph
    class TestTimeline < Test::Unit::TestCase
      def test_sanity
          assert_nothing_raised(Exception) do
              t = Timeline.new do
                  event "Test", 2010, "awesome"
              end
          end
      end
    end
end
