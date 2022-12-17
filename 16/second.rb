#!/usr/bin/env ruby
# Expected: 1707

require "scanf"
require "rgl/adjacency"
require "rgl/dijkstra.rb"
require "parallel"

Valve = Struct.new(:name, :rate, :leads_to)

G = RGL::DirectedAdjacencyGraph.new
valves = {}
STDIN
    .readlines(chomp: true)
    .each do |line|
        name, rate, leads = line.scanf("Valve %s has flow rate=%d; %*s %*s to %*s %[^\n]")
        valves[name] = Valve.new(name, rate, leads.split(",").map(&:strip))
        G.add_vertex(name)
    end
valves.values.each { |v| v.leads_to.each { |d| G.add_edge(v.name, d) } }

LEN = valves.keys.permutation(2).to_h { |s, e| [[s, e], G.dijkstra_shortest_path(Hash.new(1), s, e).size] }
def released(root, closed, t)
    return 0 if t >= 26

    released = (26 - t) * root.rate
    return released if closed.empty?

    released + closed.map { |c| released(c, closed - [c], t + LEN[[root.name, c.name]]) }.max
end

candidates = valves.values.select { |v| v.rate > 0 }
combinations = Enumerator.new do |y|
    ((candidates.size + 2) / 2).times do |n|
        candidates.combination(n).each do |combination|
            y << combination
        end
    end
end

p Parallel.map(combinations) { |combination|
    released(valves["AA"], combination, 0) +
    released(valves["AA"], candidates - combination, 0)
}
.max
