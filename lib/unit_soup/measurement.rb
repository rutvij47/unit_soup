module UnitSoup
  class Measurement
    attr_accessor :amount, :unit

    def initialize(amount, unit)
      @amount = amount.to_r
      @unit = Unit.new(unit)
    end
  end
end
