require "unit_soup/unit_set"

describe "UnitSet" do

  describe ".define string rules" do
    before do
      @soup = UnitSoup::UnitSet.define("Metric units") do |s|
          # comma separated rules without '=' sign
          s.rules "1cm = 10mm", "1km = 1000m"
          # single rule with '=' sign
          s.rules = "1m = 100cm", "1 foo = 2 bar"
          # add using <<
          s.rules << "1mm = 1000um"
          # single rule using rule method
          s.rule = "1 inch = 2.54 cm"
          # rule without '=' sign
          s.rule "12 inch = 1 foot"
        end
    end

    it "can set name" do
      expect(@soup.name).to eql "Metric units"
    end

    it "can parse rules" do
      expect(@soup.rules.length).to eql 7
    end
  end

  describe ".define Rule rules" do
    before do
      @soup = UnitSoup::UnitSet.define("Metric units") do |s|
          # comma separated rules without '=' sign
          s.rules UnitSoup::Rule.from("1cm = 10mm"), UnitSoup::Rule.new("1km = 1000m")
          # single rule with '=' sign
          s.rules = UnitSoup::Rule.from("1m = 100cm"), UnitSoup::Rule.new("1 foo = 2 bar")
          # add using <<
          s.rules << UnitSoup::Rule.new("1mm = 1000um")
          # single rule using rule method
          s.rule = UnitSoup::Rule.new("1 inch = 2.54 cm")
          # rule without '=' sign
          s.rule UnitSoup::Rule.new("12 inch = 1 foot")
        end
    end

    it "can parse rules" do
      expect(@soup.rules.length).to eql 7
    end

    it "can filter dupes" do
      @soup.rules << "12 inch = 1 foot"
      @soup.rule = "1 inch = 2.54 cm"
      #puts @soup.rules.map(&:to_s)
      expect(@soup.rules.length).to eql 7
    end
  end
end
