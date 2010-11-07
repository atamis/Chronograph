module Chronograph
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
end
