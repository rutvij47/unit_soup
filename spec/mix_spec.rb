require "unit_soup/mix"
require "unit_soup/rule"

include UnitSoup

describe "Mix" do
  describe ".define string rules" do
    # mix = Mix.define("Metric units") do |s|
    #   # single rule string
    #   s << "1foo = 2bar"
    #   # single rule object
    #   s << Rule.new("1km = 1000m")
    #
    #   # comma separated rule strings
    #   s << ["1cm = 10mm", "1km = 1.60934mile"]
    #   # comma separated rule objects
    #   s << [Rule.new("1cm = 10mm"), Rule.new("1ft = 30.48cm")]
    #   # comma separated rule objects and strings
    #   s << ["1ft = 12inch", Rule.new("1bar = 3baz")]
    #
    #   # mix
    #   s << Mix.new("US currency") do |m|
    #     m << "1dollar = 100 cent"
    #     m << "1 dime = 10 cent"
    #   end
    # end

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
