#!/usr/bin/env ruby
# Expected: 2

p STDIN
    .readlines(chomp: true)
    .map { |l| l.scan /\d+/ }
    .count { |ls, le, rs, re|
        l = ls..le
        r = rs..re
        l.cover?(r) || r.cover?(l)
    }
