#!/usr/bin/env ruby
# Expected: 140

require "../common.rb"

def compare(l, r)
    case [l, r]
    in [NilClass, _]
        return -1
    in [_, NilClass]
        return +1
    in [Integer, Integer]
        l <=> r
    in [Array, Array]
        [l.size, r.size].max.times do |i|
            io = compare(l[i], r[i])
            return io if io != 0
        end
        0
    in [Integer, _]
        compare([l], r)
    in [_, Integer]
        compare(l, [r])
    end
end

lines = STDIN.readlines(chomp: true).reject(&:empty?).map { |line| JSON.parse(line) }

sep1, sep2 = [[2]], [[6]]
lines += [sep1, sep2]

sorted = lines.sort { |l, r| compare(l, r) }
p (1 + sorted.find_index(sep1)) * (1 + sorted.find_index(sep2))
