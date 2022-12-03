#!/usr/bin/env ruby
# Expected: 24000

puts File
    .read(ARGV[0])
    .split(/\n{2,}/)
    .map { |group| group.split.sum(&:to_i) }
    .max
