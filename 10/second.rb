#!/usr/bin/env ruby
# Expected: EGJBGCFK

require "scanf"

x = 1

STDIN
    .readlines(chomp: true)
    .flat_map { |cmd| [0] + cmd.scanf("addx %d") }
    .map.with_index do |op, i|
        (x - i%40).abs <= 1 ? "█" : " "
    ensure
        x += op
    end
    .each_slice(40)
    .each { |pixels| puts pixels.join }