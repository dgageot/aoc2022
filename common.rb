require "active_support/all"
require "scanf"

class Array
    def chop
        self[..-2]
    end

    def top(count)
        self.sort.take(count)
    end

    def bottom(count)
        self.sort.reverse.take(count)
    end

    def split2()
        self.each_slice(self.size / 2)
    end

    def as_range()
        Range.new(self[0], self[1])
    end

    def second()
        self[1]
    end

    def third()
        self[2]
    end

    def fourth()
        self[4]
    end
end

class String
    def each_slice(n)
        self.chars.each_slice(n).map(&:join)
    end

    def second()
        self[1]
    end

    def third()
        self[2]
    end

    def fourth()
        self[4]
    end
end

class Range
    def intersect?(other)
        self.to_a.intersect?(other.to_a)
    end
end

