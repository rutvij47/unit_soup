require "unit_soup/unit"

include UnitSoup

describe ".new" do
  describe "from symbol" do
    unit = Unit.new(:cm)
    it "should have symbol cm" do
      expect(unit).to_not be_nil
      expect(unit.symbol).to be :cm
    end
  end

  describe "from string" do
    unit = Unit.new("cm")
    it "should have symbol cm" do
      expect(unit).to_not be_nil
      expect(unit.symbol).to be :cm
    end
  end

  describe "name from symbol" do
    unit = Unit.new("cm")
    it "should have symbol cm" do
      expect(unit).to_not be_nil
      expect(unit.name).to be :cm
    end
  end

  describe "name" do
    unit = Unit.new("cm")
    unit.name = "centimeter"
    it "should have name centimeter" do
      expect(unit).to_not be_nil
      expect(unit.name).to eq(:centimeter)
    end
  end

  describe "==" do
    cm = Unit.new("cm")
    it "should not equal inch" do
      expect(cm).to_not eq(Unit.new(:inch))
    end

    it "should equal cm" do
      expect(cm).to eq(Unit.new(:cm)) 
    end
  end
end
