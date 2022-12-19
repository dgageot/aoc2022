#!/usr/bin/env ruby
# Expected: 58

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

space = cubes.to_h { |c| [[c.x, c.y, c.z], "█"] }

cubes.each do |c|
    DIRECTIONS.each do |x, y, z|
        coord = [c.x + x, c.y + y, c.z + z]
        next if space[coord] == "█"
        space[coord] ||= 0
        space[coord] += 1
    end
end

class Tester
    def initialize(space)
        @space = space
        @min_x, @max_x = space.keys.map { |x, _, _| x }.minmax
        @min_y, @max_y = space.keys.map { |_, y, _| y }.minmax
        @min_z, @max_z = space.keys.map { |_, _, z| z }.minmax
    end

    def test
        total = @space.values.filter { |v| v != "█" }.sum
        flood
        trapped = @space.values.filter { |v| v != "█" && v != "W" }.sum
        total - trapped
    end

    private

    def flood
        @space[[@min_x, @min_y, @min_z]] = "W"
        loop do
            break if flood_once
        end
    end

    def flood_once
        changed = false
        (@min_x..@max_x).each do |x|
            (@min_y..@max_y).each do |y|
                (@min_z..@max_z).each do |z|
                    next if @space[[x, y, z]] == "█" || @space[[x, y, z]] == "W"
                    next unless DIRECTIONS.any? { |dx, dy, dz| @space[[x + dx, y + dy, z + dz]] == "W" }

                    @space[[x, y, z]] = "W" 
                    changed = true
                end
            end
        end
        changed
    end
end

p Tester.new(space).test
