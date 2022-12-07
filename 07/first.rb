#!/usr/bin/env ruby
# Expected: 95437

pwd = []
total = Hash.new(0)

File
    .readlines(ARGV[0])
    .map(&:chomp)
    .each { |cmd|
        case cmd
        when /\$ cd \.\./
            pwd.pop
        when /\$ cd (.+)/
            pwd.push($1)
        when /(\d*) .*/
            length = $1.to_i
            pwd.size.times.each { |i|
                dir = pwd[0..i]
                total[dir] += length
            }
        end
    }

p total.values.select { |v| v <= 100000 }.sum
