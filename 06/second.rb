#!/usr/bin/env ruby
# Expected: 19

len = 14

msg = File.read(ARGV[0]).chomp.chars
puts len + msg.size.times.select { |i| msg[i, len].uniq.count == len }.first
