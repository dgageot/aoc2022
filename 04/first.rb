#!/usr/bin/env ruby
# Expected: 2

require "active_support/all"

puts File
    .readlines(ARGV[0])
    .map { |l| l.split(/[,-]/).map(&:to_i) }
    .count { |g|
        l = g[0]..g[1]
        r = g[2]..g[3]
        l.cover?(r) || r.cover?(l)
    }
