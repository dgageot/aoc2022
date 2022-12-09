#!/usr/bin/env ruby
# Expected: 13140

x = 1
screen = [" "] * 240

STDIN
    .readlines(chomp: true)
    .flat_map { |line|
        case line
        when "noop"
            [0]
        when /addx (.+)/
            [0, $1.to_i]
        end
    }
    .each.with_index { |op, i|
        screen[i] = "█" if ((i%40) - x).abs <=1
        x = x + op
    }
screen.each_slice(40).each{ |line| puts line.join }
