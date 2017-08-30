require "unit_soup/mix"
require "unit_soup/rule"

include UnitSoup

describe "Mix" do
  describe ".define string rules" do
    it "can set name" do
      mix = Mix.define("Metric units")
      expect(mix.name).to eql "Metric units"
    end

    it "can parse rules in definition" do
      mix = Mix.define("Metric units") do |s|
        # single rule string
        s << "1foo = 2bar"
        # comma separated rule strings
        s << ["1cm = 10mm", "1km = 1.60934mile"]
      end
      expect(mix.rules.length).to eql 3
    end
  end

  describe "adding" do
    mix = Mix.new("mix")

    it "can add rule using <<" do
      mix << "1foo = 2bar"
      expect(mix.rules.length).to eql 1
    end

    it "can add rule using add" do
      mix.add "1 bar = 100 baz"
      expect(mix.rules.length).to eql 2
    end

    it "can filter dupes" do
      expect(mix.rules.length).to eql 2
      mix << "1foo = 2bar"
      mix << "1 bar = 100 baz"
      expect(mix.rules.length).to eql 2
    end
  end
end
