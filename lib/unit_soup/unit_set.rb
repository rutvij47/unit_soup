module UnitSoup

  class UnitSet
    def self.define(name, &block)
      set = UnitSet.new name
      block.arity < 1 ? set.instance_eval(&block) : block.call(set)
    end

    def initialize(name)
      @name = name
      @rules = []
    end

    def name(n = nil)
      return @name unless n
      @name = n
    end

    alias_method :name=, :name

    def add_rules_from_file(file)
    end

    def rules(*array)
      return @rules unless array && array.size > 0
      @rules += array.flatten if array
    end

    alias_method :rules=, :rules

    def rule(r)
      @rules << r if r
    end

    alias_method :rule=, :rule
  end
end
