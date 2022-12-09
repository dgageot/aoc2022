#!/usr/bin/env ruby
# Expected: 36

require "../common.rb"

delta = {
    "R" => [+1, +0],
    "L" => [-1, +0],
    "U" => [+0, -1],
    "D" => [+0, +1],
}
move = ->(xy, direction) { xy.zip(delta[direction]).map(&:sum) }
nearest = ->(xy, ref) {
    [
        xy.zip([-1, -1]).map(&:sum),
        xy.zip([-1, +0]).map(&:sum),
        xy.zip([-1, +1]).map(&:sum),
        xy.zip([+0, -1]).map(&:sum),
        xy.zip([+0, +0]).map(&:sum),
        xy.zip([+0, +1]).map(&:sum),
        xy.zip([+1, -1]).map(&:sum),
        xy.zip([+1, +0]).map(&:sum),
        xy.zip([+1, +1]).map(&:sum),
    ].min_by { |xy| (xy[0] - ref[0]).abs + (xy[1] - ref[1]).abs }
}

coord = [[0, 0]] * 10
seen = [coord.last]

STDIN
    .readlines(chomp: true)
    .map { |line| line.scanf("%s %d") }
    .each { |direction, step|
        step.times.each { |i|
            coord[0] = move[coord[0], direction]

            (coord.size - 1).times { |i|
                xdiff = (coord[i+1][0] - coord[i][0]).abs
                ydiff = (coord[i+1][1] - coord[i][1]).abs
                coord[i+1] = nearest[coord[i+1], coord[i]] if xdiff > 1 || ydiff > 1
            }

            seen.push(coord.last)
        }
    }

puts seen.uniq.count
