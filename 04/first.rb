#!/usr/bin/env ruby
# Expected: 2

require "../common.rb"

puts File
    .readlines(ARGV[0])
    .map { |l| l.scanf("%d-%d,%d-%d") }
    .count { |g|
        l = g[0]..g[1]
        r = g[2]..g[3]
        l.cover?(r) || r.cover?(l)
    }
