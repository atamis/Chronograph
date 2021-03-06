require "test/unit"
require "chronograph/event"

module Chronograph
    class TestChronograph < Test::Unit::TestCase
        def test_parse_date
            assert_equal(Date.today, parse_date(Date.today))
            assert_equal(Date.new(2010), parse_date(2010))
        end

        def test_errors
            assert_raise(TypeError) { Event.new(nil, nil, nil, nil)  }
        end

        def test_recall
            name = :test
            date = Date.today
            desc = "cool"
            group = :green
            e = Event.new(name, date, desc, group)
            assert_equal(name, e.name)
            assert_equal(date, e.date)
            assert_equal(desc, e.desc)
            assert_equal(group, e.group)
        end

        def test_to_table_html
            name = :test
            date = Date.today
            desc = "cool"
            group = :green
            e = Event.new(name, date, desc, group)
            # First we test without making use of Kramdown
            assert_equal("<tr class=\"#{group}\">"+
               "<td class=\"date\">#{date}</td>"+
               "<td class=\"name\">#{name}</td>"+
               "<td class=\"desc\"><p>#{desc}</p>\n</td>"+
               "</tr>", e.to_table_html)
            desc = "_cool_"
            e = Event.new(name, date, desc, group)
            # Now we start messing around with Kramdown. Note the redefinition of desc to surround cool with underscores
            assert_equal("<tr class=\"#{group}\">"+
               "<td class=\"date\">#{date}</td>"+
               "<td class=\"name\">#{name}</td>"+
               "<td class=\"desc\"><p><em>cool</em></p>\n</td>"+
               "</tr>", e.to_table_html)
        end
        # And that's all she wrote, folks. There isn't much else to test.
    end
end
