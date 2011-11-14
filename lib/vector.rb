module Mustererkennung
  class Vector
    attr_accessor :x, :y

    def initialize(*elements)
      if elements.size < 2
        @x, @y = 0, 0
      else
        @x, @y = *elements
      end
    end

    def distance(other)
      Math.sqrt(self * other)
    end

    # elementwise sumation or sum of vectors
    def +(other)
      if other.kind_of? Fixnum
        Vector.new(x + other, y + other)
      elsif other.kind_of? Vector
        Vector.new(x + other.x, y + other.y)
      end
    end

    # elementwise multiplication or outer product
    def *(other)
      if other.kind_of? Fixnum
        Vector.new(x*other, y*other)
      elsif other.kind_of? Vector
        x * other.x + y * other.y
      end
    end

    # elementwise division
    def /(denominator)
      Vector.new(x/denominator.to_f, y/denominator.to_f)
    end

    def ==(other)
      x == other.x && y == other.y
    end
  end
end

