#!/usr/bin/env ruby
# Expected: MCD

require "../common.rb"

crates, moves = File
    .readlines(ARGV[0])
    .split(&:blank?)

stacks = crates[0..-2]
    .map { |line| line.scan(/.(.). ?/).flatten }
    .transpose
    .map { |list| list.reject(&:blank?).reverse }

moves
    .map { |move| move.scanf("move %d from %d to %d")}
    .each { |count, from, to|
        stacks[to - 1] += stacks[from - 1].pop(count)
    }

puts stacks.map(&:last).join
