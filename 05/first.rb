#!/usr/bin/env ruby
# Expected: CMZ

require "active_support/all"
require 'scanf'

stacks = []
map, moves = File
    .readlines(ARGV[0])
    .split(&:blank?)

map
    .reverse[1..-1]
    .map { |line| line.scan(/....?/) }
    .each { |line|
        line.each_with_index { |v, i|
            stacks[i] = (stacks[i] || []) + [v[1]] if !v.blank?
        }
    }

moves
    .each { |move|
        count, from, to = move.scanf("move %d from %d to %d")
        stacks[to - 1] += stacks[from - 1].pop(count).reverse
    }

puts stacks.map(&:last).join
