#!/usr/bin/env ruby
# Expected: 1651

require "scanf"
require "rgl/adjacency"
require "rgl/dijkstra.rb"

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
    return 0 if t >= 30

    released = (30 - t) * root.rate
    return released if closed.empty?

    released + closed.map { |c| released(c, closed - [c], t + LEN[[root.name, c.name]]) }.max
end

closed = valves.values.select { |v| v.rate > 0 }
p released(valves["AA"], closed, 0)
