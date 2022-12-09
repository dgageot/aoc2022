#!/usr/bin/env ruby
# Expected: 13140

# require "../common.rb"

x = 1
# cycle = 1
strength = 0
screen = ["."] * 240

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
        cycle = i + 1
        if ((cycle + 20) % 40) == 0 then
            strength += (cycle * x)
        end
        x = x + op
    }
p screen.split(40)
