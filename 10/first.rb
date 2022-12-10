#!/usr/bin/env ruby
# Expected: 13140

require "../common.rb"

x = 1
strength = 0

STDIN
    .readlines(chomp: true)
    .flat_map { |cmd| [0] + cmd.scanf("addx %d") }
    .each_with_index { |op, i|
        cycle = i + 1
        strength += (cycle * x) if ((cycle + 20) % 40) == 0
        x += op
    }
p strength
