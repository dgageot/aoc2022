#!/usr/bin/env ruby
# Expected: CMZ

require "active_support/all"
require 'scanf'

map, moves = File
    .readlines(ARGV[0])
    .split(&:blank?)

stacks = map[0..-2]
    .map { |line| line.scan(/.(.). ?/).flatten }
    .transpose
    .map { |list| list.reject(&:blank?).reverse }

moves
    .map { |move| move.scanf("move %d from %d to %d")}
    .each { |count, from, to|
        stacks[to - 1] += stacks[from - 1].pop(count).reverse
    }

puts stacks.map(&:last).join
