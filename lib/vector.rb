# 2 dimensional Vector with label
module Mustererkennung
  class Vector
    attr_accessor :elements, :label

    def initialize(label = nil, *elements)
      @elements = elements
      @label = label
    end

    # Euclidean distance between self and other
    def distance(other)
      Math.sqrt([ elements, other ].inject(0) { |memo, element|
        memo += (element - memo.delete_at(0)) ** 2
        memo
      })
    end

    # elementwise sumation or sum of vectors
    def +(other)
      if other.kind_of? Fixnum
        @x += other
        @y += other
        self
      elsif other.kind_of? Vector
        Vector.new(@x + other.x, @y + other.y, label = other)
      end
    end

    # elementwise multiplication or outer product
    def *(other)
      if other.kind_of? Fixnum
        @x *= other
        @y *= other
        self
      elsif other.kind_of? Vector
        x * other.x + y * other.y
      end
    end

    # elementwise division
    def /(denominator)
      @x /= denominator.to_f
      @y /= denominator.to_f
      self
    end

    def label=(other)
      if label == other.label
        label
      elsif label.nil? && ! other.label.nil?
        other.label
      elsif ! label.nil? && other.label.nil?
        label
      else
        nil
      end
    end

    def ==(other)
      x == other.x && y == other.y
    end

    # Attribute vector to the nearest centroid.
    # Takes Array of Vectors, returns the nearest one.
    def cluster(centroids)
      centroids.inject({}) do |m, mean|
        m[mean] = distance(mean)
        m
      end.min_by(&:last).first
    end
  end
end

