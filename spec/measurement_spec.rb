require "unit_soup/measurement"
require "unit_soup/unit"

include UnitSoup

describe "Measurement" do
  describe ".new" do
    describe "from strings" do
      m = Measurement.new("3/4", "cm")

      it "should have initialized correctly" do
        expect(m.amount).to eq(3/4r)
        expect(m.unit).to eq(Unit.new(:cm))
      end
    end
  end
end
