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


# algo
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

# classes
Rule = Measurement - Measurement
Measurement = Amount.to_r Unit
Unit(to_sym, symbols)
Amount(to_r)
Soup = set<rule>

Soup
 @mix = Mix.new(name)
  @units = []
  @rules = []
 @symbols_map = {:symbol => unit}
 @lookup
 @graph


# brainstorming unit singletons
mix << rules
mix[:unit].symbols << :cms
soup.prepare
soup.unit[:unit].same_as :longer_name
soup.make
soup = Soup.new("mysoup", mix1, mix2)
soup << mix3
soup << rule1, rule2, mix
soup.unit(:unit).field
soup.units[:unit].symbols



# unit additional functionality
:singular, :plural,
def initialize(options={})
  @symbols = []
  @name = options[:name].to_sym if options[:name]
  @singular = options[:singular].to_sym if options[:singular]
  @plural = options[:plural].to_sym if options[:plural]
  @symbol = options[:use].to_sym if options[:use]
  @symbol = options[:symbol].to_sym if @symbol.nil? && options[:symbol]
  @symbol = options[:preffered].to_sym if @symbol.nil? && options[:preffered]
  @symbols += options[:aliases] if options[:aliases]
  @symbols += options[:symbols] if options[:symbols]
end

def symbols
  (@symbols + [@name, @singular, @plural, @symbol]).reject{|s|s.blank?}.sort.uniq
end

alias_method :preffered, :symbol
