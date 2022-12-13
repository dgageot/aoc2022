#!/usr/bin/env ruby
# Expected: 140

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

separators = [ [[2]], [[6]] ]

STDIN
    .readlines(chomp: true)
    .reject(&:empty?)
    .map { |line| JSON.parse(line) }
    .push(*separators)
    .sort { |l, r| compare(l, r) }
    .tap { |sorted|
        p separators.map { |sep| 1 + sorted.find_index(sep) }.inject(&:*)
    }
