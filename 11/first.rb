#!/usr/bin/env ruby
# Expected: 10605

require "scanf"

class Monkey
    attr_reader :items, :op, :divisor, :ifTrue, :ifFalse, :inspected

    def initialize(items, op, divisor, ifTrue, ifFalse)
        @items, @op, @divisor, @ifTrue, @ifFalse = items, op, divisor, ifTrue, ifFalse
        @inspected = 0
    end

    def receive(item)
        @items.push(item)
    end

    def clear
        @items = []
    end

    def tally
        @inspected += @items.size
    end

    def target(item)
        (item % divisor) == 0 ? ifTrue : ifFalse
    end
end

monkeys = STDIN
    .readlines(chomp: true)
    .chunk_while { |line| !line.empty? }
    .map { |desc|
        items = desc[1].split(": ")[1].split(", ").map(&:to_i)
        sign, v = desc[2].scanf("  Operation: new = old %s %s")
        op = ->(old) { old * old } if sign == "*" && v == "old"
        op = ->(old) { old * v.to_i } if sign == "*" && v != "old"
        op = ->(old) { old + v.to_i } if sign == "+"
        divisor = desc[3].scanf("Test: divisible by %d")[0]
        ifTrue = desc[4].scanf("If true: throw to monkey %d")[0]
        ifFalse = desc[5].scanf("If false: throw to monkey %d")[0]
        Monkey.new(items, op, divisor, ifTrue, ifFalse)
    }

20.times.each do |round|
    monkeys.each do |monkey|
        monkey.tally
        monkey.items.each do |item|
            worry = monkey.op[item] / 3
            monkeys[monkey.target(worry)].receive(worry)
        end
        monkey.clear
    end
end

p monkeys.map(&:inspected).sort.last(2).inject(&:*)

