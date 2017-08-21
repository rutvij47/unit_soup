module UnitSoup

  class Unit
    attr_reader :name, :symbol

    def initialize(symbol)
      @symbol = symbol.to_sym
      @name = @symbol.to_sym
    end

    def name=(name)
      @name = name.to_sym
    end

    def to_s
      symbol.to_s
    end

    def ==(o)
      symbol == o.symbol
    end

    def hash
      symbol.hash
    end
  end
end
