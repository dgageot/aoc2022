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

    def play(turn, form, debug = false)
        # if @current_move == 161 && form.name == "-"
        #     # puts turn
        #     # exit
        # end
        # key = [@current_move, form.name]
        # if @cache[key] != nil then
        #     if @current_move == 161 && form.name == "-"
        #         puts "YES!!! #{turn} #{@cache[key]} #{@current_move} #{form.name}"
        #     end
        #     # exit
        # else
        #     @cache[key] = turn
        #     # puts "#{turn} #{@current_move} #{form.name}"
        # end

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

    def debug
        length = 9
        return if @lines.size < (length * 2)

        @lines[0, @lines.size - length].each_cons(length) do |pattern|
            if pattern == @lines[-length..] then
                puts height
                exit
            end
        end

        # p @lines
        # p @lines[0] 
        # p @lines[1]
        # p @lines[-2]
        # p @lines[-1]

        # if @lines[0] == @lines[-1] then 
        #     p "!!!!!!!!! #{height}"
        # end
        # exit
    end
end

moves = STDIN.readlines(chomp: true)[0].chars

forms = [
    ["-", ["..@@@@."]],
    ["+", ["...@...", "..@@@..", "...@..."]],
    ["L", ["....@..", "....@..", "..@@@.."]],
    ["I", ["..@....", "..@....", "..@....", "..@...."]],
    ["□", ["..@@...", "..@@..."]],
].cycle

# 15 -> 25
# 16 -> 26
# 16+35x1 -> 79 = 26 + 56
# 16+35x2 -> 132 = 26 + 53x2
# 16+35x3 -> 185 = 26 + 53x2
# (((1000000000000 - 16 + 1) / 35) * 53) + 25

# 1764 -> 2817
# 1765 -> 2817
# 1765+111 -> 2973 = 156 + 2817
# 1765+1735*1 -> 5598 = 2817 + 2781 * 1
# 1765+1735*1+110 -> 5753 = 2817 + 2781 * 1 + 155
# 1765+1735*2 -> 8379 = 2817 + 2781 * 2
# 1765+1735*3 -> 11160 = 2817 + 2781 * 3
# 1765+1735*4 -> 13941 = 2817 + 2781 * 4
# 1765+1735*30 -> 86247 = 2817 + 2781 * 30
# 1765+1735*56 -> 158553 = 2817 + 2781 * 56
# 1765+1735*56 -> 158553
# 1765+1735*30+110 -> 86402 = 2817 + 2781 * 30 + 155
# 1765+(1735*576368875) ->  2817 + 2781 * 576368875 = 1602881844192
# 1765+(1735*576368875)+110=1000000000000 -> 2817 + 2781 * 576368875 + 155
# 1602881844347

board = Board.new(moves)
(1765+1735*30+110).times { |i|
    desc = forms.next
    board.play(i, Form.new(desc[0], desc[1]))
}
p board.height
