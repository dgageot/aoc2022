#!/usr/bin/env ruby
# Expected: 1707

require "scanf"
require "set"
require "rgl/adjacency"
require "rgl/dijkstra.rb"

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
        @cache = {}
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
cache = {}
max = 0

# 2576
candidates.size.times do |n|
    candidates.permutation(n).each do |perm|
        left = perm.sort
        right = candidates - left

        lr = cache[left] ||= Search.new(valves).released("AA", left, 0)
        rr = cache[right] ||= Search.new(valves).released("AA", right, 0)
        lr + rr
        if lr + rr > max then
            max = lr + rr
            p max
        end
    end
end
p max
