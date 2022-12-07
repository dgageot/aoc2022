#!/usr/bin/env ruby
# Expected: 157

p STDIN
    .readlines(chomp: true)
    .map(&:chars)
    .map { |line| line.each_slice(line.size / 2) }
    .flat_map { |lr| lr.inject(:&) }
    .sum(&[*'a'..'z', *'A'..'Z'].zip(1..52).to_h)
