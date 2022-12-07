#!/usr/bin/env ruby
# Expected: 45000

require "../common.rb"

p STDIN
    .readlines(chomp: true)
    .split(&:blank?)
    .map { |values| values.sum(&:to_i) }
    .sort
    .last(3)
    .sum
