require "unit_soup/rule"
require "unit_soup/measurement"

include UnitSoup

describe "Rule" do
  describe ".valid?" do
    it "recognizes valid with spaces" do
      expect(Rule.valid? "1 km = 1000 m   ").to be true
    end

    it "recognizes valid with spaces" do
      expect(Rule.valid? "1km=1000m").to be true
    end

    it "recognizes invalid - no equals" do
      expect(Rule.valid? "1km-1000m").to be false
    end

    it "recognizes invalid - no this amount" do
      expect(Rule.valid? "km=1000m").to be false
    end

    it "recognizes invalid - no that amount" do
      expect(Rule.valid? "1km=m").to be false
    end

    it "recognizes invalid - no this unit" do
      expect(Rule.valid? "1=1000m").to be false
    end

    it "recognizes invalid - no that unit" do
      expect(Rule.valid? "1km=m").to be false
    end

    it "recognizes invalid - no amounts" do
      expect(Rule.valid? "km=m").to be false
    end

    it "recognizes invalid - no units" do
      expect(Rule.valid? "1=1000").to be false
    end
  end

  describe ".initialize" do
    it "raises error when nil" do
      expect {Rule.new(nil)}.to raise_error ArgumentError
    end

    it "raises error when invalid" do
      expect {Rule.new("hello world")}.to raise_error ArgumentError
    end

    it "initializes" do
      expect(Rule.new("1 foo = 3 bar")).to_not be_nil
    end
  end

  describe ".from" do
    it "raises error when nil" do
      expect {Rule.from(nil)}.to raise_error ArgumentError
    end

    it "raises error when invalid" do
      expect {Rule.from("hello world")}.to raise_error ArgumentError
    end

    it "initializes" do
      expect(Rule.from("1 foo = 3 bar")).to_not be_nil
    end
  end

  describe ".to_s" do
    it "formats to string correctly" do
      expect(Rule.new(" 1 foo = 3 bar").to_s).to eq "1/1 foo = 3/1 bar"
    end
  end

  describe "measurements" do
    r = Rule.new("1 foo = 3 bar")
    it "parses measurements correctly" do
      expect(r.this_measurement).to eq(Measurement.new(1, :foo))
      expect(r.that_measurement).to eq(Measurement.new(3, :bar))
    end
  end
end
