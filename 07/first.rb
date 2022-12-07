#!/usr/bin/env ruby
# Expected: 95437

pwd = []
total = Hash.new(0)

STDIN.each_line(chomp: true) do |line|
    case line
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

p total.values.select { |v| v <= 100000 }.sum
