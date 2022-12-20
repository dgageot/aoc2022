#!/usr/bin/env ruby
# Expected: 3

numbers = STDIN
    .readlines(chomp: true)
    .map.with_index { |line, i| [line.to_i, i] }

len = numbers.size
len.times do |index|
    i = numbers.index { |v| v.last == index }
    number = numbers[i]
    v = number.first
    next if v == 0

    dest = (i + v) % (len-1)
    numbers.delete_at(i)
    numbers.insert(dest, number)
end

numbers = numbers.map(&:first)
i = numbers.index(0)
p numbers[(i+1000)%len] + numbers[(i+2000)%len] + numbers[(i+3000)%len]