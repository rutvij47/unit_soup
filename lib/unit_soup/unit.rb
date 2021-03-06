module UnitSoup

  class Unit
    attr_reader :name, :symbol

    def initialize(name=nil, symbol)
      @symbol = symbol.to_sym
      @name = name.nil? ? @symbol.to_sym : name.to_sym
    end

    def name=(name)
      @name = name.to_sym
    end

    def to_s
      symbol.to_s
    end

    def to_sym
      symbol.to_sym
    end

    def ==(o)
      symbol == o.symbol
    end

    def eql?(o)
      symbol == o.symbol
    end

    def hash
      symbol.hash
    end
  end
end
