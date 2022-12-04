#!/usr/bin/env ruby
# Expected: 24000

require "active_support/all"

puts File
    .readlines(ARGV[0])
    .split(&:blank?)
    .map { |values| values.sum(&:to_i) }
    .max
