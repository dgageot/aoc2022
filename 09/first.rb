#!/usr/bin/env ruby
# Expected: 88

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

h = [0, 0]
t = [0, 0]
seen = [t]

STDIN
    .readlines(chomp: true)
    .map { |line| line.scanf("%s %d") }
    .each { |direction, step|
        step.times.each { |i|
            h = move[h, direction]

            xdiff = (t[0] - h[0]).abs
            ydiff = (t[1] - h[1]).abs
            t = nearest[t, h] if xdiff > 1 || ydiff > 1

            seen.push(t)
        }
    }

puts seen.uniq.count
