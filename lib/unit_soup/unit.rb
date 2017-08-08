module UnitSoup

  class Unit
    attr_reader :name, :singular, :plural, :symbol

    def initialize(symbol)
      @symbols = [symbol.to_sym]
      @symbol = @symbols.first
      @name = name.to_sym
    end

    def initialize(options={})
      @symbols = []
      @name = options[:name].to_sym if options[:name]
      @singular = options[:singular].to_sym if options[:singular]
      @plural = options[:plural].to_sym if options[:plural]
      @symbol = options[:use].to_sym if options[:use]
      @symbol = options[:symbol].to_sym if @symbol.nil? && options[:symbol]
      @symbol = options[:preffered].to_sym if @symbol.nil? && options[:preffered]
      @symbols += options[:aliases] if options[:aliases]
      @symbols += options[:symbols] if options[:symbols]
    end

    def symbols
      (@symbols + [@name, @singular, @plural, @symbol]).reject{|s|s.blank?}.sort.uniq
    end

    alias_method :preffered, :symbol
  end
end
