#!/usr/bin/env ruby
# Expected: 70

require "../common.rb"

puts File
    .readlines(ARGV[0])
    .map(&:chomp)
    .each_slice(3)
    .flat_map { |group| group.map(&:chars).inject(:&) }
    .sum(&[*'a'..'z', *'A'..'Z'].zip(1..52).to_h)
