# trying out api

pack = UnitPack.create(name: "time periods") do |p|
  p.name = "time periods"
  p.desc = "some description"
  p.rules  = [
    "7 days = 1 week"
  ]
  p.rules File("conversion.rules")
  # p.rules [
  #   {days: 7, week: 1}
  #   {weekday: 5, week: 1}
  #   {weekday: 1, days: 1}
  #   {weekend: 1, days: 2}
  #   {weekend: 1, week: 1}
  # ]
  p.aliases = {
    days: %w(day days)

  }
end


Rule.new("1 days", "24 hours")
Convertible::Unit(:name, %w(aliases), rules)
Convertible::Measurement
Convertible::Unit
Convertible::DefinitionSet
Convertible::RuleSet
Measurement/Reading
Rule = measurementA = measurementB
UnitPack.merge()
UnitPack.convert measurementA unitB
UnitPack.conversionFactor measurementA unitB
DefinitionSet/ConversionRuleSet/UnitPack/UnitGroup

UnitSoup::Unit
UnitSoup::Measurement
UnitSoup::Mix

soupmix = Mix.new()
soup.make
soup.add(Mix::ImperialUnits)
soup.make
soup.convert(measurement, "cm")
soup.conversion_factor("inch", "cm")
soup.conversion_path("inch", "cm")
soup.rules << Mix | Rule | rules
soup.rules = Mix | Rule | rules
soup.rules Mix | Rule | rules
soup.rule = Rule
soup.rule Rule

BudgetItem < Convertible::Measurement

SetDefinition

metric_units = Convertible::Set.define do
  name "Metric Units"
  rules [
    "100 cm = 1 decimeter",
    "100 decimeter = 1 meter",
    "1000 meter = 1 km"
  ]
  rule "2.5 cm = 1 inch"
  rules_from_file :file_path
  unit(:km).same_as("KM", :kilo_meters) # aliases
  unit(:centimeter).use_symbol("cm")
  unit(:cm).use_plural("centimeters")
  unit(:cm).use_singular(short: cm, long="centimeter")
  unit(:cm).use(symbol: :cm, singular: :centimeter, :plural: "centimeters", name: "Centimeter")
  unit(:cm).rule("2.5cm", "1 inch")
  unit(:cm).rule("2.5", 1, unit(:inch))
  unit(:cm).rule("2.5", unit(1, :inch))
end

Convertible::Set.from/with/union (Convertible::SetDefinition::Metric, dollar_units)
my_set.add(dollar_units).


algo
@lookup @graph
convert(measurement, from, to)
  return from lookup if lookup has from, to factor
  bfssearch from to - when found, take path, collect factors
  return converted or show error

when rules change
    reset lookup and graph
    build graph from rules
      rules.each do
        graph[this][that]=factor
        graph[that][this]=1/factor

Rule = Measurement - Measurement
Measurement = Amount Unit
Unit(string)
Amount(double)
Soup = set<rule>
