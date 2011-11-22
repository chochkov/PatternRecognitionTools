# A multidimensional vector.
#
require "#{File.dirname(__FILE__)}/vector_class_methods"

module Mustererkennung
  class Vector
    attr_accessor :label, :elements, :dimension

    alias :size :dimension

    extend VectorClassMethods

    def initialize(opts = {}, *args, &block)
      if opts.kind_of? Hash
        self.label = opts[:label]
        arguments  = args.flatten
      else
        arguments  = [ opts, args ].flatten
      end

      self.elements =
        if block_given? && Vector.same_dimension?(arguments)
          self.label = defined?(@label) ? @label : arguments.first.label
          Vector.elementwise(arguments, &block)
        else
          arguments
        end

      self.dimension = elements.size
    end

    # elementwise sumation or sum of vectors
    def +(arg)
      if Vector.vector?(arg)
        Vector.new({ :label => common_label(arg) }, self, arg) { |x, y| x + y }
      else
        Vector.new({ :label => label }, map { |e| e + arg })
      end
    end

    # elementwise difference or difference of vectors
    def -(arg)
      if Vector.vector?(arg)
        Vector.new({ :label => common_label(label)}, self, arg) { |x, y| x - y }
      else
        Vector.new({ :label => label }, map { |e| e - arg })
      end
    end

    # elementwise multiplication or outer product
    def *(other)
      if other.kind_of? Fixnum
        Vector.new({ :label => label }, map { |e| e * other })
      elsif other.kind_of? Vector
        inject(0, other) do |memo, x, y|
          memo += x * y
        end
      end
    end

    # elementwise division
    def /(denominator)
      Vector.new({ :label => label }, map { |e| e / denominator })
    end

    def distance(other)
      Math.sqrt(inject(0, other) { |memo, x, y|
        memo += (x - y) ** 2
      })
    end

    def common_label(other)
      if other.label == label
        label
      else
        labels = [ label, other.label ].compact
        if labels.size < 2
          labels.first
        else
          nil
        end
      end
    end

    def same_dimension?(*vectors)
      Vector.same_dimension? self, *vectors
    end

    def [](i)
      elements[i]
    end

    def ==(*others)
      others.flatten.all? do |vector|
        vector.elements == elements
      end
    end

    def push(*elements)
      self.elements.push(*elements)
      self.dimension += elements.size
      self
    end

    def all?(&block); elements.all? &block; end

    def any?(&block); elements.any? &block; end

    def map(&block); elements.map &block; end

    def inject(start, *vectors)
      raise DimensionMismatch unless same_dimension?(vectors)

      (0..dimension - 1).inject(start) do |memo, i|
        yield(memo, *[self[i], *vectors.map { |vector| vector[i] }])
      end
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

