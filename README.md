# UnitSoup

Unit Soup is a DRY approach to unit conversion.
Specify a set of conversion rules and you can start converting from one unit to another.

## Analogy
- `Mix` is a ready-made set of units and conversion rules.
- `Soup` is made from (soup) mixes.
- `Measurement` is amount of items of a particular type (unit). (e.g. 3 cars, 4 miles)
- `Soup` can convert one `measurement` to another if possible.

## Usage
* Add as many `mixes` to `soup`.
* Make the `soup`.
* Start converting `measurements` from one unit to another.

## Examples
#### Metric Units

```ruby
require "unit_soup/mix"
require "unit_soup/soup"

metric_units_mix = Mix.new("Metric Units") do |m|
  m << "1 cm = 10 mm"
  m << "1 dm = 10 cm"
  m << "1 m = 100 cm"
  m << "1 dcm = 10 m"
  m << "1 hcm = 100 m"
  m << "1 km = 1000 m"
end
soup = Soup.new("Metric Soup (mm to km)")
soup << metric_units_mix
soup.make

# convert 550 centimeters to meters
soup.convert(550, :cm, :m) #=> 5.5
# convert 50000 centimeters to kilometers
soup.convert(50000, :cm, :km) #=> 0.5
```

#### Simple expenses calculator

```ruby
require "unit_soup/mix"
require "unit_soup/soup"

expenses_per_time_period_mix = Mix.new("Expenses/TimePeriod") do |mix|
  mix << "1 per_day = 7 per_week"
  mix << "1 per_week = 4 per_month"
  mix << "1 per_month = 12 per_year"
  mix << "1 per_weekend = 1 per_week"
  mix << "1 per_weekday = 5 per_week"
end

soup = Soup.new("Expense calculator")
soup << expenses_per_time_period_mix
soup.make


parking_per_week = Measurement.new(50, "per_week")
parking_per_month = soup.convert(parking_per_week, :per_month) #=> 200
parking_per_year = soup.convert(parking_per_week, :per_year) #=> 2400
```


## Details
### Unit
- Has `name` and `symbol`
- `Unit.new("Kilometer", :km)` or `Unit.new(:km)`
- Usually inferred from the rules

### Measurement
- Describes things like "3 cars", "4 miles"
- Has `amount` and `unit`
- m = `Measurement.new("3 car")`
  - `m.unit` => `:car`
  - `m.amount` => `3/1 (rational)`
- Other ways to initialize
  - `Measurement.from("4 mile")`
  - `Measurement.new(4, :mile)`
  - `Measurement.new(4, Unit.new(:mile))`
  - `Measurement.new(2.5, :mile)`
  - `Measurement.new("2.5", :mile)`
  - `Measurement.new(3/2r, :mile)`
  - `Measurement.new("3/2", :mile)`
  - `Measurement.from(another_measurement)`

### Rule
- Describes conversion rule from one unit to another.
- Can be specified as equality of two measurements.
- `1 km = 1000 m`
  - `this_measurement` = `1 km`, `that_measurement` = `1000 m`
- r = `Rule.new("1 km = 1000 m")` or `Rule.new("1000 m = 1 km")`  
- `valid?` can be used to check if a string can be parsed into a `Rule`
- Can be initialized as
  - `Rule.new "1 km = 1000 m"`     
  - `Rule.from "1 km = 1000 m"`
  - `Rule.from another_rule`
  - `Rule.new measurement_a, measurement_b`
  - `Rule.new Measurement.new("1 km"), Measurement.new(1000, :m)`

### Mix
- Represents a set of rules
- Can be used to group related units together. e.g. Metric Units, time units, etc.
- Has a name and a Set of rules
- Initializing: time_units = `Mix.new("Time Units")` or `Mix.define("Time Units")`
- Adding Rules:
  - `time_units << "1 minute = 60 second"`
  - `time_units << Rule.new("1 minute = 60 second")`
  - `time_units.add "1 minute = 60 second"`
  - `time_units.add Rule.new("1 minute = 60 second")`
  - From Rule strings list: `distance << ["1cm = 10mm", "1km = 1.60934mile"]`
  - From Rule list: `distance << [Rule.new("1cm = 10mm"), Rule.new("1km = 1.60934mile")]`
  - From mixed list: `distance << ["1cm = 10mm", Rule.new("1km = 1.60934mile")]`
  - From other mixes:
    - `my_mix << time_units`
    - `my_mix << distance_units`

- Initialize via block:
```
time_units = Mix.define("Time units") do |m|  
  m << "1 minute = 60 second"
  m << ["1 hour = 60 minute", "1 millisecond  = 1000 second"]
end
```

### Soup
- Soup allows conversion from one unit to another
- Has an optional name
- Supports adding rules from strings, lists and mixes exactly like `Mix`
  - `Soup.new("time_soup") << time_units_mix`
- Add as many related/unrelated rules and mixes as you like to the soup
- `make`: Make the soup (internally creates a graph of all rules for conversion lookups)
- `convert(value, from, to)` => rational representing converted value in target unit
  - `convert(2, :minute, :second)` => 120/1  
  - `convert(2, Unit.new(:minute), :second)` => 120/1
  - `convert(50, :foo, :bar)` => `nil` #if conversion was not possible  
- Return value is a rational to keep precision
- `make` needs to be called before `convert`s can work

#### Conversion
- `soup.make` Creates a graph from the rules. So,  

  ```ruby
  soup = Soup.new("my_distance_converter")
  soup << Mix.new("my_distance_mix") do |m|
    m << "1 centimeter = 10 millimeter"
    m << "1 decimeter = 10 centimeter"
    m << "1 centimeter = 100 meter"    
    m << "1 centimeter = 0.39 inch"    
    m << "1 foot = 12 inch"
    m << "1 kilometer = 1000 meter"    
    m << "1 kilometer = 0.62 mile"    
  end
  soup.make
  ```

  becomes
  ```
                    +------------+
                    | millimeter |
                    +------------+
                          |
                          |
                          |
  +-----------+     +------------+     +------+     +------+
  | decimeter | --- | centimeter | --- | inch | --- | foot |
  +-----------+     +------------+     +------+     +------+
                          |
                          |
                          |
  +-----------+     +------------+
  | kilometer | --- |   meter    |
  +-----------+     +------------+
        |
        |
        |
  +-----------+
  |   mile    |
  +-----------+
  ```

- Any rules added after `soup.make` will not be a part of the graph until another call to `soup.make` is made.

- A `lookup` is initialized internally with all direct conversions inferred from the set of rules. e.g. From "1 foot = 12 inch" we can infer `lookup[:foot][:inch]=12` and `lookup[:inch][:foot]=1/12`

- `soup.convert(2, :foot, :inch)` - `lookup` has information to convert from `foot` to `inch`, so `convert` returns `2 * (lookup[:foot][:inch]=12) = 24/1`

- `soup.convert(200, :foot, :meter)` - `lookup` does not have this information, so a `bfs` graph traversal starting from `foot` is performed. It gives us the following chain that can be traversed to get the right fraction for multiplication to perform conversion:

  ```
  +-------+      +------------+      +------+      +------+
  | meter | <--- | centimeter | <--- | inch | <--- | foot |
  +-------+      +------------+      +------+      +------+

  200 * lookup[:foot][:inch] * lookup[:inch][:centimeter] * lookup[:centimeter][:meter]
  ```

  This conversion fraction is also saved in `lookup[:foot][:meter]` and `lookup[:meter][:foot]` so the next conversion from `foot` to `meter` does not perform a graph traversal.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'unit_soup'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install unit_soup

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
