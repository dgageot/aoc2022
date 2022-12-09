#!/usr/bin/env ruby
# Expected: 13140

x = 1
strength = 0

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
        strength += (cycle * x) if [20, 60, 100, 140, 180, 220].include?(cycle)
        x += op
    }
p strength
