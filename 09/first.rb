#!/usr/bin/env ruby
# Expected: 88

require "../common.rb"

class XY
    attr_reader :x, :y

    def initialize(x, y) @x, @y = x, y end

    def move(h, v) XY.new(x + h, y + v) end

    def dist(t) (x - t.x) ** 2 + (y - t.y) ** 2 end

    def nearest(ref)
        return self if dist(ref) <= 2
        [-1, 0, +1]
            .product([-1, 0, +1])
            .map { |x, y| move(x, y) }
            .min_by { |xy| xy.dist(ref) }
    end
end

delta = {
    "R" => [+1, +0],
    "L" => [-1, +0],
    "U" => [+0, -1],
    "D" => [+0, +1],
}

knots = [XY.new(0, 0)] * 2
seen = Set[[knots.last.x, knots.last.y]]

STDIN
    .readlines(chomp: true)
    .map { |line| line.scanf("%s %d") }
    .flat_map { |direction, step| [delta[direction]] * step }
    .map { |∆|
        knots[0] = knots[0].move(*∆)
        (knots.size - 1).times { |i| knots[i+1] = knots[i+1].nearest(knots[i]) }
        seen.add([knots.last.x, knots.last.y])
    }

puts seen.count
