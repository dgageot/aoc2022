#!/usr/bin/env ruby
# Expected: 3068

EMPTY = "......."

class Form
    attr_reader :lines

    def initialize(lines)
        @lines = lines.map { |line| line.dup }
    end

    def height
        @lines.size
    end

    def jet(direction)
        if direction == ">"
            if @lines.all? { |line| line[-1] == "." } then
                return Form.new(@lines.map { |line| line[-1] + line[0..-2] })
            end
        elsif direction == "<"
            if @lines.all? { |line| line[0] == "." } then
                return Form.new(@lines.map { |line| line[1..-1] + line[0] })
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
    end

    def draw(form, row)
        form.lines.each.with_index do |line, y|
            line.each_char.with_index do |c, x|
                if c == "@" then
                    @lines[row + y][x] = "#" 
                end
            end
        end
    end

    def fits(form, row)
        form.lines.each.with_index do |line, y|
            line.each_char.with_index do |c, x|
                if c != "." then
                    return false if @lines[row + y] == nil
                    if @lines[row + y][x] != "." then
                        return false
                    end
                end
            end
        end
        true
    end

    def play(form, debug = false)
        add_lines(3 + form.height)
        row = 0
        loop do
            debug(form, row) if debug
            move = @moves[@current_move]
            @current_move = (@current_move + 1) % @moves.size
            moved = form.jet(move)
            if fits(moved, row) then
                puts "FITS #{move}" if debug
                debug(form, row) if debug
                form = moved
                debug(form, row) if debug
            else
                puts "NO FIT #{move}" if debug
            end
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

    def print
        puts "============================================="
        puts @lines.map { |line| line }.join("\n")
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

forms = [
    ["..@@@@."],
    ["...@...", "..@@@..", "...@..."],
    ["....@..", "....@..", "..@@@.."],
    ["..@....", "..@....", "..@....", "..@...."],
    ["..@@...", "..@@..."],
].cycle

board = Board.new(moves)
2022.times { |i| board.play(Form.new(forms.next)) }
p board.height
