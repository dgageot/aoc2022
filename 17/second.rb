#!/usr/bin/env ruby
# Expected: 1514285714288

EMPTY = "......."

class Form
    attr_reader :lines, :name

    def initialize(name, lines)
        @name = name
        @lines = lines.map { |line| line.dup }
    end

    def height
        @lines.size
    end

    def jet(direction)
        if direction == ">"
            if @lines.all? { |line| line[-1] == "." } then
                return Form.new(@letter, @lines.map { |line| line[-1] + line[0..-2] })
            end
        elsif direction == "<"
            if @lines.all? { |line| line[0] == "." } then
                return Form.new(@letter, @lines.map { |line| line[1..-1] + line[0] })
            end
        end
        return self
    end
end

class Board
    def initialize(moves)
        @lines = []
        @moves = moves
        @current_move = 0
        @cache = {}
        @cycle_key = nil
        @cycle_start = 0
        @forms = [
            ["-", ["..@@@@."]],
            ["+", ["...@...", "..@@@..", "...@..."]],
            ["L", ["....@..", "....@..", "..@@@.."]],
            ["I", ["..@....", "..@....", "..@....", "..@...."]],
            ["□", ["..@@...", "..@@..."]],
        ].cycle
    end

    def draw(form, row)
        form.lines.each.with_index do |line, y|
            line.each_char.with_index do |c, x|
                @lines[row + y][x] = "#" if c == "@"
            end
        end
    end

    def fits(form, row)
        form.lines.each.with_index do |line, y|
            line.each_char.with_index do |c, x|
                if c != "." then
                    return false if @lines[row + y] == nil
                    return false if @lines[row + y][x] != "."
                end
            end
        end
        true
    end

    def play(turn, search_cycles = false)
        form = Form.new(*@forms.next)
        if search_cycles then
            key = [@current_move, form.name]
            return @cache[key], @cycle_start, turn if key == @cycle_key

            if @cache[key] != nil then
                if @cycle_key == nil then
                    @cycle_start = turn
                    @cycle_key = key
                end
            else
                @cache[key] = turn
            end
        end

        add_lines(3 + form.height)
        row = 0
        loop do
            move = @moves[@current_move]
            @current_move = (@current_move + 1) % @moves.size
            moved = form.jet(move)
            form = moved if fits(moved, row)
            if !fits(form, row + 1) then
                draw(form, row)
                return
            end
            row += 1
        end
    ensure
        crop_all
    end

    def height
        @lines.size
    end

    def crop
        return if @lines.empty?
        if @lines[0] == EMPTY then
            @lines = @lines[1..]
        end
    end

    def crop_all
        loop do
            size = @lines.size
            crop
            break if size == @lines.size
        end
    end

    def add_lines(count)
        count.times do |_|
            @lines = [EMPTY.dup] + @lines
        end
    end
end

moves = STDIN.readlines(chomp: true)[0].chars

cycle_finder = Enumerator.new do |y|
    board = Board.new(moves)
    10000.times { |i|
        result = board.play(i, true)
        if result != nil then
            y << result
            return
        end
    }
end

start, from, to = cycle_finder.first
cycle = to - from

board = Board.new(moves)
(from + 1).times { |i| board.play(i)}
from_height = board.height

board = Board.new(moves)
(to + 1).times { |i| board.play(i)}
to_height = board.height
per_cycle = to_height - from_height

count = 1000000000000
remaining = (count - (from + 1)) % cycle
cycles = (count - (from + 1)) / cycle

board = Board.new(moves)
(from + remaining + 1).times { |i| board.play(i)}
remaining_height = board.height

p per_cycle * cycles + remaining_height
