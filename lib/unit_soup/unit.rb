module UnitSoup

  class Unit
    attr_reader :name, :singular, :plural, :preffered

    def initialize(name)
      @symbols = []
      @name = name.to_sym
    end

    def initialize(options={})
      @symbols = []
      @name = options[:name].to_sym unless options[:name].blank?
      @singular = options[:singular].to_sym unless options[:singular].blank?
      @plural = options[:plural].to_sym unless options[:plural].blank?
      @preffered = options[:use].to_sym unless options[:use].blank?
      @preffered = options[:preffered].to_sym unless @preffered || options[:preffered].blank?
      @symbols += options[:aliases] if options[:aliases]
      @symbols += options[:symbols] if options[:symbols]
    end

    def symbols
      (@symbols + [@name, @singular, @plural, @preffered]).reject{|s|s.blank?}.sort.uniq
    end

    def preffered
      @preffered
    end
  end
end
