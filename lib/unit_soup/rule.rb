require "unit_soup/unit"
require "unit_soup/measurement"

include UnitSoup

module UnitSoup
  class Rule
    def self.valid?(str)
      return false unless str
      strs = str.split '='
      strs.length > 1 && Measurement.valid?(strs[0]) && Measurement.valid?(strs[1])
    end

    def self.from(r)
      self.new r
    end

    attr_reader :this_measurement, :that_measurement

    def initialize(*args)
      case args.length
      when 1
        r = args[0]
        raise ArgumentError.new("No argument provided") unless r
        if r.is_a? Rule
          @this_measurement = Measurement.new r.this_measurement
          @that_measurement = Measurement.new r.that_measurement
        else
          strs = r.to_s.split '='
          raise ArgumentError.new("Format: 12 inch = 1 foot") unless strs.length == 2
          @this_measurement = Measurement.new strs[0]
          @that_measurement = Measurement.new strs[1]
        end
      else
        @this_measurement = Measurement.new(args[0])
        @that_measurement = Measurement.new(args[1])
      end
    end

    def to_s
      "#{this_measurement} = #{that_measurement}"
    end

    def ==(o)
      this_measurement == o.this_measurement && that_measurement == o.that_measurement
    end

    def eql?(o)
      this_measurement == o.this_measurement && that_measurement == o.that_measurement
    end

    def hash
      to_s.hash
    end
  end
end
