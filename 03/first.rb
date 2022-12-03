#!/usr/bin/env ruby
# Expected: 157

def priority(l)
    l.ord >= 'a'.ord ? l.ord - 'a'.ord + 1 : l.ord - 'A'.ord + 27
end

puts File
    .foreach(ARGV[0])
    .map { |line| priority(line.partition(/.{#{line.size/2}}/)[1,2].map { |s| s.split("")}.inject(:&).first)}
    .sum
