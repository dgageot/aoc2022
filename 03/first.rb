#!/usr/bin/env ruby
# Expected: 157

priorities = [*'a'..'z', *'A'..'Z'].zip(1..52).to_h

puts File
    .foreach(ARGV[0])
    .map(&:chomp)
    .map(&:chars)
    .map { |line| line.each_slice(line.size / 2) }
    .flat_map { |lr| lr.inject(:&) }
    .map(&priorities)
    .sum
