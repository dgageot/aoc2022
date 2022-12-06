#!/usr/bin/env ruby
# Expected: 19

len = 14

File
    .read(ARGV[0])
    .chomp
    .chars
    .tap { |msg| puts len + msg.size.times.find { |i| msg[i, len].uniq.count == len }}
