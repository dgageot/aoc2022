#!/usr/bin/env ruby
# Expected: 45000

require "../common.rb"

puts File
    .readlines(ARGV[0])
    .split(&:blank?)
    .map { |values| values.sum(&:to_i) }
    .sort
    .last(3)
    .sum
