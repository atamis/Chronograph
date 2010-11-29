module Chronograph
    class Event
        attr_accessor :name, :date, :desc, :group
        def initialize(name, date, desc, group=:default)
            raise TypeError.new("date must be a date") unless date.is_a? Date
            raise TypeError.new("name has to be a name or symbol") unless name.is_a?(String) || name.is_a?(Symbol)
            raise TypeError.new("desc must be a string") unless desc.is_a? String
            raise TypeError.new("group has to be a name or symbol") unless group.is_a?(String) || group.is_a?(Symbol)
            @name = name
            @date = date
            @desc = desc
            @group = group
        end

        def to_table_html
            "<tr class=\"#{@group}\">"+
               "<td class=\"date\">#{@date}</td>"+
               "<td class=\"name\">#{@name}</td>"+
               "<td class=\"desc\">#{@desc}</td>"+
               "</tr>"
        end
    end
end

def parse_date x
    x.is_a?(Integer) ? Date.new(x) : x
end
