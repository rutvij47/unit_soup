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

  # describe "conversion factor" do
  #
  # end
  #
  # describe "conversion chain" do
  #
  # end
end
