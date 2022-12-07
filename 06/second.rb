#!/usr/bin/env ruby
# Expected: 19

len = 14

STDIN.readline(chomp: true)
    .chars
    .each_cons(len)
    .find_index { |letters| letters.uniq.count == len }
    .tap { |i| p len + i }
