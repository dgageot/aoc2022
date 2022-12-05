#!/usr/bin/env ruby
# Expected: 157

require "../common.rb"

puts File
    .readlines(ARGV[0])
    .map(&:chomp)
    .map(&:chars)
    .map { |line| line.each_slice(line.size / 2) }
    .flat_map { |lr| lr.inject(:&) }
    .sum(&[*'a'..'z', *'A'..'Z'].zip(1..52).to_h)
