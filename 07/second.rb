#!/usr/bin/env ruby
# Expected: 24933642

pwd = []
total = Hash.new(0)

File
    .readlines(ARGV[0])
    .map(&:chomp)
    .each do |cmd|
        case cmd
        when "$ cd .."
            pwd.pop
        when /\$ cd (.+)/
            pwd.push($1)
        when /(\d*) .*/
            length = $1.to_i
            pwd.size.times.each do |i|
                dir = pwd[0..i]
                total[dir] += length
            end
        end
    end

required = total[["/"]] - 40000000
puts total.values.select { |v| v >= required }.sort.first
