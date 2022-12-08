#!/usr/bin/env ruby
# Expected: 8

grid = STDIN
    .readlines(chomp: true)
    .map(&:chars)

transposed = grid.transpose

max = 0

grid.each_with_index do |row, y|
    row.each_with_index do |tree, x|
        left = row[0...x]
        right = row[x+1...]
        up = transposed[x][0...y]
        down = transposed[x][y+1...]

        scenic = ->(neighbours) {
            highest = neighbours.index { |t| t >= tree }
            highest ? highest + 1 : neighbours.size
        }

        score = scenic[up.reverse] * scenic[down] * scenic[left.reverse] * scenic[right]
        max = [max, score].max
    end
end

p max
