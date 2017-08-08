require "unit_soup/rule"
require "unit_soup/unit"
require "set"

module UnitSoup
  class UnitSet
    def self.define(name, &block)
      set = UnitSet.new name
      block.arity < 1 ? set.instance_eval(&block) : block.call(set)
      set
    end

    def initialize(name)
      @name = name
      @rules = []
      @units = []
    end

    def name(n = nil)
      return @name unless n
      @name = n
    end

    alias_method :name=, :name

    def add_rules_from_file(file)
      #TODO: parse riles from file
    end

    # string array or rules array or mix of rules and strings
    def rules(*array)
      return @rules unless array && array.size > 0
      add_new_rules(array.flatten) if array
    end

    alias_method :rules=, :rules

    def rule(r)
      add_new_rules([r]) if r
    end

    alias_method :rule=, :rule

    private
    ##
    # Add new rules and extract units
    #
    def add_new_rules(rules)
      return unless rules.class == Array
      existing_rules = @rules.map(&:to_s)
      puts "existing----------"
      puts existing_rules
      puts "existing----------\n"
      rules.reject{|r| existing_rules.include?(r.to_s)}.each do |r|
        unit_symbols = @units.map(&:symbol)
        rule = r.class == UnitSoup::Rule ? r : UnitSoup::Rule.new(r.to_s)
        @units << UnitSoup::Unit.new(use: rule.this_unit) unless unit_symbols.include?(rule.this_unit)
        @units << UnitSoup::Unit.new(use: rule.that_unit) unless unit_symbols.include?(rule.that_unit)
        @rules << rule
      end
    end
  end
end
