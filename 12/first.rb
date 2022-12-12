#!/usr/bin/env ruby
# Expected: 31

require "rgl/adjacency"
require "rgl/dijkstra.rb"

class Node
    attr_reader :letter

    def initialize(letter)
        @letter = letter
    end
end

start = [0, 0]
dest = [0, 0]
nodes = {}
graph = RGL::DirectedAdjacencyGraph.new

STDIN
    .readlines(chomp: true)
    .map(&:chars)
    .each.with_index do |row, y|
        row.each.with_index do |letter, x|
            if letter == "S" then
                start = [x, y]   
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

path = graph.dijkstra_shortest_path(Hash.new(1), nodes[start], nodes[dest])
p path.size - 1
