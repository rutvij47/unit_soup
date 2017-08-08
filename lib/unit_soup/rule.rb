module UnitSoup
  class Rule
    @@rule_format = /(\d+|\d+.\d+)+([[:alpha:]]+)=(\d+|\d+.\d+)([[:alpha:]]+)/

    def self.valid?(str)
      str && !str.to_s.gsub("\s", "").match(@@rule_format).nil?
    end

    def self.from(str)
      self.new str
    end

    attr_accessor :this_amt, :this_unit, :that_amt, :that_unit

    def initialize(str)
      raise ArgumentError.new("No argument provided") unless str
      str = str.to_s
      match_data = str.to_s.gsub("\s", "").match(@@rule_format)
      raise ArgumentError.new("Format: 12 inch = 1 foot") unless match_data
      @this_amt = match_data[1]
      @this_unit = match_data[2]
      @that_amt = match_data[3]
      @that_unit = match_data[4]
    end

    def to_s
      "#{this_amt} #{this_unit} = #{that_amt} #{that_unit}"
    end

    def eql?(o)
      o.class == UnitSoup::Rule
      this_unit == o.this_unit
      this_amt == o.that_amt
      that_unit == o.that_unit
      that_amt == o.that_unit
    end

    def hash
      to_s.hash
    end
  end
end
