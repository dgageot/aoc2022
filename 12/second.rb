#!/usr/bin/env ruby
# Expected: 29

require "rgl/adjacency"
require "rgl/dijkstra.rb"
require "parallel"

class Node
    attr_reader :letter

    def initialize(letter)
        @letter = letter
    end
end

dest = [0, 0]
nodes = {}
graph = RGL::DirectedAdjacencyGraph.new

STDIN
    .readlines(chomp: true)
    .map(&:chars)
    .each.with_index do |row, y|
        row.each.with_index do |letter, x|
            if letter == "S" then
                letter = "a" 
            elsif letter == "E" then
                dest = [x, y]
                letter = "z"
            end

            node = Node.new(letter)
            graph.add_vertex(node)
            nodes[[x, y]] = node
        end
    end

nodes.each do |xy, node|
    x, y = *xy
    [[x - 1, y], [x + 1, y], [x, y + 1], [x, y - 1]]
    .map { |coord| nodes[coord] }
    .compact
    .select { |neighbour| neighbour.letter.ord <= node.letter.ord + 1 }
    .each { |neighbour| graph.add_edge(node, neighbour) }
end

starts = nodes.values.select { |node| node.letter == "a" }
        
p Parallel
    .map(starts) { |node| graph.dijkstra_shortest_path(Hash.new(1), node, nodes[dest]) }
    .compact
    .map { |result| result.size - 1 }
    .min

