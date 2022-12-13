#!/usr/bin/env ruby
# Expected: 13

require "json"

def compare(l, r)
    case [l, r]
    in [NilClass, _]
        return -1
    in [_, NilClass]
        return +1
    in [Integer, Integer]
        l <=> r
    in [Array, Array]
        [l.size, r.size].max.times.map { |i| compare(l[i], r[i]) }.select { |v| v != 0 }.first || 0
    in [Integer, _]
        compare([l], r)
    in [_, Integer]
        compare(l, [r])
    end
end

p STDIN
    .readlines(chomp: true)
    .each_slice(3)
    .map { |l, r, _| [JSON.parse(l), JSON.parse(r)] }
    .map.with_index { |lr, i| compare(*lr) < 0 ? i + 1 : 0 }
    .sum
