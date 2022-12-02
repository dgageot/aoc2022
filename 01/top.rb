#!/usr/bin/env ruby

puts File.read("input").split(/\n{2,}/).map { |group| group.split.map { |line| line.to_i }.sum }.max
