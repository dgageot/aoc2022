#!/usr/bin/env ruby
# Expected: 64

Cube = Struct.new(:x, :y, :z)
DIRECTIONS = [
    [+1, +0, +0],
    [-1, +0, +0],
    [+0, +1, +0],
    [+0, -1, +0],
    [+0, +0, +1],
    [+0, +0, -1],
]

cubes = STDIN
    .readlines(chomp: true)
    .map { |line| line.split(",").map(&:to_i) }
    .map { |x, y, z| Cube.new(x, y, z) }

space = cubes.to_h { |c| [[c.x, c.y, c.z], 1] }

p cubes.map { |c| 6 - DIRECTIONS.count { |x, y, z| space[[c.x + x, c.y + y, c.z + z]] == 1 } }.sum
