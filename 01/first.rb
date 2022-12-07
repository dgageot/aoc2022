#!/usr/bin/env ruby
# Expected: 24000

require "../common.rb"

p STDIN
    .readlines(chomp: true)
    .split(&:blank?)
    .map { |values| values.sum(&:to_i) }
    .max
