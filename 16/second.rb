#!/usr/bin/env ruby
# Expected: 1707

require "scanf"
require "set"
require "rgl/adjacency"
require "rgl/dijkstra.rb"
require "parallel"

class Valve
    attr_reader :name, :rate, :leads_to

    def initialize(name, rate, leads_to)
        @name, @rate, @leads_to = name, rate, leads_to
    end
end

D = 26
G = RGL::DirectedAdjacencyGraph.new
valves = {}
STDIN
    .readlines(chomp: true)
    .each do |line|
        spec = line.split("; ")
        name, rate = spec[0].scanf("Valve %s has flow rate=%d")
        leads_to = spec[1][22..].split(", ").map(&:strip)
        valve = Valve.new(name, rate, leads_to)
        valves[name] = valve
        G.add_vertex(valve.name)
    end

valves.values.each { |v| v.leads_to.each { |d| G.add_edge(v.name, d) } }
LENGTH = {}
valves.values.permutation(2) do |s, e|
    LENGTH[[s.name, e.name]] = G.dijkstra_shortest_path(Hash.new(1), s.name, e.name).size
end

class Search
    def initialize(valves)
        @valves = valves
    end

    def released(root, candidates, t)
        return 0 if t >= D

        released = (D - t) * @valves[root].rate
        return released if candidates.empty?

        released + candidates.map { |c|
            released(c, candidates - [c], t + LENGTH[[root, c]])
        }.max
    end
end

candidates = valves.values.select { |v| v.rate > 0 }.map { |v| v.name }
combinations = Enumerator.new do |y|
    ((candidates.size + 2) / 2).times do |n|
        candidates.combination(n).each do |combination|
            y << combination
        end
    end
end

search = Search.new(valves)
p Parallel.map(combinations) { |combination|
    search.released("AA", combination, 0) +
    search.released("AA", candidates - combination, 0)
}
.max
