# A 2 dimensional vector with label
module Mustererkennung
  class Vector
    attr_accessor :x, :y, :label

    def initialize(x = nil, y = nil, label = nil)
      @x = x
      @y = y
      @label = label
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

    # Attribute vector to the nearest centroid
    # Returns the nearest centroid, a Vector object
    def cluster(centroids)
      centroids.inject({}) do |m, mean|
        m[mean] = vector.distance(mean)
        m
      end.min_by(&:last).first
    end
  end
end

