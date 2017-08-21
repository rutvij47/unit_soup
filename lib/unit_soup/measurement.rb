require "unit_soup/unit"

include UnitSoup

module UnitSoup
  class Measurement
    @@measurement_format = %r{(\d+|\d+.\d+|\d+/d+)([[:alpha:]]+)}

    def self.valid?(str)
      str && !str.to_s.gsub("\s", "").match(@@measurement_format).nil?
    end

    def self.from(str)
      self.new str
    end

    attr_reader :amount, :unit

    def initialize(*args)
      case args.length
      when 1
        str = args[0]
        raise ArgumentError.new("No argument provided") unless str
        str = str.to_s
        match_data = str.to_s.gsub("\s", "").match(@@measurement_format)
        raise ArgumentError.new("Format: 12 inch") unless match_data        
        @amount = match_data[1].to_r
        @unit = Unit.new(match_data[2])
      else
        @amount = args[0].to_r
        @unit = Unit.new(args[1].to_sym)
      end
    end

    def to_s
      "#{amount} #{unit}"
    end

    def ==(o)
      amount == o.amount
      unit == o.unit
    end

    def hash
      to_s.hash
    end
  end
end
