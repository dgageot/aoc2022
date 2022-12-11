#!/usr/bin/env ruby
# Expected: 31

require "rgl/adjacency"
require "rgl/dijkstra.rb"

class Node
    attr_reader :x, :y, :letter

    def initialize(letter, x, y)
        @letter, @x, @y = letter, x, y
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
        row.each.with_index do |elevation, x|
            if elevation == "S" then
                start = [x, y]   
                elevation = "a" 
            elsif elevation == "E" then
                dest = [x, y]
                elevation = "z"
            end

            node = Node.new(elevation, x, y)
            graph.add_vertex(node)
            nodes[[x, y]] = node
        end
    end

nodes.each_value do |node|
    x, y = node.x, node.y
    [[x - 1, y], [x + 1, y], [x, y + 1], [x, y - 1]]
    .map { |coord| nodes[coord] }
    .compact
    .select { |neighbour| neighbour.letter.ord <= node.letter.ord + 1 }
    .each { |neighbour| graph.add_edge(node, neighbour) }
end

path = graph.dijkstra_shortest_path(Hash.new(1), nodes[start], nodes[dest])
p path.size - 1
