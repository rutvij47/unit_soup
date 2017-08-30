require "unit_soup/measurement"
require "unit_soup/unit"

include UnitSoup

describe "Measurement" do
  describe ".new" do
    describe "from separate strings" do
      m = Measurement.new("3/4", "cm")

      it "should have initialized correctly" do
        expect(m.amount).to eq(3/4r)
        expect(m.unit).to eq(Unit.new(:cm))
      end
    end

    describe "from single string" do
      m = Measurement.new("4/5 inch")

      it "should have initialized correctly" do
        expect(m.amount).to eq(4/5r)
        expect(m.unit).to eq(Unit.new(:inch))
      end
    end

    describe "from objects" do
      m = Measurement.new(2.5, :cm)

      it "should have initialized correctly" do
        expect(m.amount).to eq(2.5)
        expect(m.unit).to eq(Unit.new(:cm))
      end
    end

    describe "from measurement" do
      m = Measurement.new(Measurement.new(2, :cm))

      it "should have initialized from measurement" do
        expect(m.amount).to eq(2)
        expect(m.unit.symbol).to eq(:cm)
      end
    end
  end

  describe "to_s" do
    m = Measurement.new(2, :cm)

    it "should convert to string correctly" do
      expect(m.to_s).to eq("2/1 cm")
    end
  end

  describe "==" do
    m = Measurement.from("2.5 cm")
    it "should equal another with same values" do
      expect(m).to eq(Measurement.new(5/2.to_r, "cm"))
    end

    it "should not equal different values" do
      expect(m).to_not eq(Measurement.new(3/2.to_r, "cm"))
    end
  end

  describe "valid" do
    it "should be valid for int amount" do
      expect(Measurement.valid?("2 cm")).to be(true)
    end

    it "should be valid for decimal amount" do
      expect(Measurement.valid?("2.5 cm")).to be(true)
    end

    it "should be valid for rational amount" do
      expect(Measurement.valid?("3/5 cm")).to be(true)
    end

    it "should be valid for rational amount" do
      expect(Measurement.valid?("3.3/5 cm")).to be(true)
    end

    it "should be invalid for invalid format" do
      expect(Measurement.valid?("invalid string 2 cm")).to be(false)
    end
  end
end
