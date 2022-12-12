#!/usr/bin/env ruby
# Expected: 13

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

p STDIN
    .readlines(chomp: true)
    .split(&:empty?)
    .map { |l, r| [JSON.parse(l), JSON.parse(r)] }
    .map.with_index { |lr, i| compare(*lr) < 0 ? i + 1 : 0 }
    .sum
