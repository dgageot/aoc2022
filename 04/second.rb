#!/usr/bin/env ruby
# Expected: 4

p STDIN
    .readlines(chomp: true)
    .map { |l| l.scan /\d+/ }
    .count { |ls, le, rs, re|
        l = ls..le
        r = rs..re
        l.to_a.intersect?(r.to_a)
    }
