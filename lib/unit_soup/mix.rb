require "unit_soup/rule"
require "unit_soup/unit"
require "set"

module UnitSoup
  class Mix
    def self.define(name, &block)
      mix = Mix.new name
      if(block)
        block.arity < 1 ? mix.instance_eval(&block) : block.call(mix)
      end
      mix
    end

    attr_reader :name, :rules

    def initialize(name)
      @name = name
      @rules = Set.new
    end

    def <<(arg)
      new_rules = []
      if arg.is_a? Mix
        new_rules << arg.rules
      elsif arg.is_a? Rule
        new_rules << arg
      elsif arg.is_a? Enumerable
        new_rules += arg.map do |a|
          if a.is_a? Rule
            a
          else
            Rule.new(a)
          end
        end
      else
        new_rules << Rule.new(arg)
      end
      new_rules.each {|r| @rules.add r}
    end

    alias_method :add, :<<

    def add_rules_from_file(file)
      #TODO: parse rules from file
    end
  end
end
