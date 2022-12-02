#!/usr/bin/env ruby
# Expected: 24000

puts File.read(ARGV[0]).split(/\n{2,}/).map { |group| group.split.map { |line| line.to_i }.sum }.max
