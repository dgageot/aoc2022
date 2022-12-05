#!/usr/bin/env ruby
# Expected: NaN

require "../common.rb"

puts File
    .readlines(ARGV[0])
    .map(&:chomp)
    .count
