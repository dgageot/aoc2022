#!/usr/bin/env ruby
# Expected: 56000011

require "scanf"
require "parallel"

lines = STDIN
    .readlines(chomp: true)
    .map { |line| line.scanf("Sensor at x=%d, y=%d: closest beacon is at x=%d, y=%d") }

max = (lines.count == 14) ? 20 : 4000000

detections = lines.map { |xs, ys, xb, yb| [xs, ys, xb, yb, (xs - xb).abs + (ys - yb).abs] }

Parallel.each(max.times.each_slice(max / 8)) do |ys|
    ys.each do |y|
        last_min = 0
    
        detections
            .map { |xs, ys, xb, yb, distance|
                maxd = distance - (ys - y).abs
                [[[xs - maxd, 0].max, max].min, [[xs + maxd, 0].max, max].min]
            }
            .filter { |range| range.last > range.first }
            .sort_by(&:first)
            .each { |range|
                if range.first > (last_min + 1) then
                    x = last_min + 1
                    p x * 4000000 + y
                    raise Parallel::Kill
                end
                last_min = [last_min, range.last].max
            }
    end
end

