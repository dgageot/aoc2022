#!/usr/bin/env ruby
# Expected: 70

def priority(l)
    l.ord >= 'a'.ord ? l.ord - 'a'.ord + 1 : l.ord - 'A'.ord + 27
end

puts File
    .foreach(ARGV[0])
    .map(&:chomp)
    .each_slice(3)
    .map { |group| priority(group.map { |s| s.split("") }.inject(:&).first)}
    .sum
