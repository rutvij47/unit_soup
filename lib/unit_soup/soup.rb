require "unit_soup/rule"
require "unit_soup/unit"
require "unit_soup/mix"

include UnitSoup

module UnitSoup
  class Soup
    attr_reader :name
    def initialize(name="_")
      @name = name
      @mix = Mix.new("default")
      @units = Set.new
      @rules = Set.new
      # symbol -> unit
      @symbols_map = {}
      @lookup = {}
      @graph = {}
    end

    def <<(m)
      @mix << m
    end

    def rules
      @mix.rules
    end

    def make
      @units.clear
      @lookup = {}
      @graph = {}
      @mix.rules.each do |r|
        @units << r.this_measurement.unit
        @units << r.that_measurement.unit
        this_unit = r.this_measurement.unit
        that_unit = r.that_measurement.unit

        this_in_that = Measurement.new((r.that_measurement.amount/r.this_measurement.amount).rationalize, that_unit)
        that_in_this = Measurement.new((r.this_measurement.amount/r.that_measurement.amount).rationalize, this_unit)

        # add direct conversions to lookup
        @lookup[[r.this_measurement.unit, r.that_measurement.unit]] = this_in_that
        @lookup[[r.that_measurement.unit, r.this_measurement.unit]] = that_in_this

        # build graph
        # rule "3 foo = 4 bar" represented as {foo => [4/3 bar], bar => [3/4 foo]}
        @graph[r.this_measurement.unit] = Set.new unless @graph.include?(r.this_measurement.unit)
        @graph[r.this_measurement.unit] << this_in_that
        @graph[r.that_measurement.unit] = Set.new unless @graph.include?(r.that_measurement.unit)
        @graph[r.that_measurement.unit] << that_in_this
      end
    end

    def convert(value, from, to)
      from = Unit.new(from)
      to = Unit.new(to)
      return nil unless @units.include?(from) && @units.include?(to)
      return (value * (@lookup[[from, to]]).amount) if @lookup.include? [from, to]
      # bfs graph from from-to. When found, walk through parent path and multiply all conversion factors.
      Struct.new("Child", :measurement, :parent)
      queue = [Struct::Child.new(Measurement.new(value, from), nil)]
      while !queue.empty? do
        parent = queue.first
        # Find all measurement matches
        # e.g. if graph[:from] = ["3/4 :foo", "4/5 :bar", "3/1 :to", "5/1 :to"]
        #    then matches = ["3/1 :to", "5/1 :to"]
        #    Since there are two valid rules to convert :from -> :to, we pick the first one
        matches = @graph[parent.measurement.unit].select{|m|m.unit == to}
        if(matches.size > 0)
          # create the chain [from, a, b, c, to], starting with 'to' and building back
          chain_from_to = [Struct::Child.new(matches.first, parent)]
          curr = chain_from_to.first
          while(curr.parent) do
            chain_from_to.unshift curr.parent # add current parent to front of chain
            curr = curr.parent
          end
          return chain_from_to.map{|c|c.measurement.amount}.inject(1){|m1,m2| m1 * m2}
        else
          children = @graph[parent.measurement.unit]
          children_not_in_queue = children.reject{|m| queue.include? m}
          queue += children_not_in_queue.map{|m| Struct::Child.new(m, parent)}
          queue.shift
        end
      end
    end
  end
end
