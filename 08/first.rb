#!/usr/bin/env ruby
# Expected: 21

grid = STDIN
    .readlines(chomp: true)
    .map(&:chars)

transposed = grid.transpose

count = 0

grid.each_with_index do |row, y|
    row.each_with_index do |tree, x|
        left = row[0...x]
        right = row[x+1...]
        up = transposed[x][0...y]
        down = transposed[x][y+1...]

        count +=1 if [left, right, up, down].any? { |neighbours| neighbours.none? { |t| t >= tree} }
    end
end

p count
