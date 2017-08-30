require "unit_soup/unit"
require "unit_soup/rule"
require "unit_soup/mix"
require "unit_soup/soup"

include UnitSoup

describe "Soup" do
  # describe ".new" do
  #   # s = Soup.new "test_soup"
  #   # it "should initialize with name" do
  #   #   expect(s.name).to eq("test_soup")
  #   # end
  # end
  #
  # describe "adding" do
  #   describe "mix" do
  #
  #   end
  #
  #   describe "rules" do
  #
  #   end
  # end
  #
  # describe "make" do
  #
  # end

  describe "convert" do

    describe "metric units" do
      soup = Soup.new("length soup")
      soup << Mix.new("Metric") do |m|
        m << "1 cm = 10 mm"
        m << "1 dm = 10 cm"
        m << "1 m = 100 cm"
        m << "1 dcm = 10 m"
        m << "1 hcm = 100 m"
        m << "1 km = 1000 m"
      end
      soup.make

      it "should convert" do
        expect(soup.convert(550, :cm, :m)).to eq(5.5)
        expect(soup.convert(50000, :cm, :km)).to eq(0.5)
      end
    end

    describe "budget" do
      soup = Soup.new "budget"
      soup << Mix.new("Expenses/TimePeriod") do |mix|
        mix << "1 per_day = 7 per_week"
        mix << "1 per_week = 4 per_month"
        mix << "1 per_month = 12 per_year"
        mix << "1 per_weekend = 1 per_week"
        mix << "1 per_weekday = 5 per_week"
      end
      soup.make

      it "should convert" do
        coffee_per_weekday = Measurement.new(4, "per_weekday")
        coffee_per_week = soup.convert(coffee_per_weekday.amount, coffee_per_weekday.unit, :per_week)
        coffee_per_month = soup.convert(coffee_per_weekday.amount, coffee_per_weekday.unit, :per_month)
        coffee_per_year = soup.convert(coffee_per_weekday.amount, coffee_per_weekday.unit, :per_year)
        expect(coffee_per_week).to eql(20.rationalize)
        expect(coffee_per_month).to eql(80.rationalize)
        expect(coffee_per_year).to eql(80*12.rationalize)
      end

    end
  end

  # describe "conversion factor" do
  #
  # end
  #
  # describe "conversion chain" do
  #
  # end
end
