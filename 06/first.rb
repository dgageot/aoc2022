#!/usr/bin/env ruby
# Expected: 7

len = 4

File
    .read(ARGV[0])
    .chomp
    .chars
    .each_cons(len)
    .find_index { |letters| letters.uniq.count == len }
    .tap { |i| p len + i }
