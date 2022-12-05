#!/usr/bin/env ruby
# Expected: 24000

require "../common.rb"

puts File
    .readlines(ARGV[0])
    .split(&:blank?)
    .map { |values| values.sum(&:to_i) }
    .max
