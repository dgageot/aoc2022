#!/usr/bin/env ruby
# Expected: 24

class Cave
    attr_reader :sand

    def initialize(rocks)
        @grid = []
        @sand = 0
        @depth = 1 + rocks.map { |line| line.map { |_, depth| depth }.max }.max
        rocks.each { |line| line.each_cons(2) { |from, to| add_rocks(from, to) } }
    end

    def add_temp_sand(x, y)
        column(@temp[0])[@temp[1]] = " " if @temp != nil
        column(x)[y] = "◯"
        @temp = [x, y]
    end

    def add_sand(x, y)
        column(@temp[0])[@temp[1]] = " " if @temp != nil
        @temp = nil
        column(x)[y] = "◯"
        @sand += 1
    end

    def empty?(x, y)
        column(x)[y] == " "
    end

    def bottom?(x, y)
        column(x)[y] == "X"
    end

    def print
        system "clear"
        puts @grid.select { |line| line != nil }.transpose.map(&:join)[0..-2].join("\n")
        puts
    end

    private

    def add_rocks(from, to)
        Range.new(*[from[1], to[1]].sort).each { |y| add_rock(from[0], y) }
        Range.new(*[from[0], to[0]].sort).each { |x| add_rock(x, from[1]) }
    end

    def add_rock(x, y)
        column(x)[y] = "█"
    end

    def column(x)
        @grid[x] ||= ([" "] * @depth) + ["X"]
    end
end

rocks = STDIN
    .readlines(chomp: true)
    .map { |line| line.split(" -> ").map { |v| v.split(",").map(&:to_i) } }

cave = Cave.new(rocks)

cave.empty?(493,0)

loop do
    x, y = 500, 0
    loop do
        if cave.empty?(x, y + 1) then
            y += 1
        elsif cave.empty?(x - 1, y + 1) then
            x, y = x - 1, y + 1
        elsif cave.empty?(x + 1, y + 1) then
            x, y = x + 1, y + 1
        else
            raise if cave.bottom?(x, y + 1)
            break
        end
        # cave.add_temp_sand(x, y)
        # cave.print
        # sleep 0.02
    end

    cave.add_sand(x, y)
    # cave.print
    # sleep 0.02
rescue
    break
end

p cave.sand



