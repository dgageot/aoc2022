#!/usr/bin/env ruby
# Expected: 7

len = 4

STDIN.readline(chomp: true)
    .chars
    .each_cons(len)
    .find_index { |letters| letters.uniq.count == len }
    .tap { |i| p len + i }
