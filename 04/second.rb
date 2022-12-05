#!/usr/bin/env ruby
# Expected: 4

require "../common.rb"

puts File
    .readlines(ARGV[0])
    .map { |l| l.scanf("%d-%d,%d-%d") }
    .count { |g|
        l = g[0]..g[1]
        r = g[2]..g[3]
        l.to_a.intersect?(r.to_a)
    }
