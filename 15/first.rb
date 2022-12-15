#!/usr/bin/env ruby
# Expected: 26
# 5461729

require "scanf"

lines = STDIN
    .readlines(chomp: true)
    .map { |line| line.scanf("Sensor at x=%d, y=%d: closest beacon is at x=%d, y=%d") }

y = (lines.count == 14) ? 10 : 2000000
    
ranges = lines
    .map { |xs, ys, xb, yb|
        maxd = (xs - xb).abs + (ys - yb).abs - (ys - y).abs
        ((xs - maxd)..(xs + maxd))
    }
    .filter { |range| range.last > range.first }
    .sort_by(&:first)

last_max = ranges[0].first
used = ranges.sum { |range|
    used = range.last - [range.first, last_max].max + 1
    last_max = [last_max, range.last + 1].max
    used < 0 ? 0 : used
}

p used - lines
    .select { |_, _, xb, yb| yb == y }
    .map { |_, _, xb, _| xb }
    .uniq
    .count { |xb| ranges.any? { |range| range.include?(xb) } }
