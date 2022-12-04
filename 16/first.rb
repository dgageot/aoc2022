#!/usr/bin/env ruby
# Expected: NaN

require "active_support/all"

puts File
    .readlines(ARGV[0])
    .map(&:chomp)
    .count
