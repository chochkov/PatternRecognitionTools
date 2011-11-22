# A collection of vectors with the same dimensions.
#
class Vectors
  include Enumerable
  attr_accessor :vectors, :dimension

  def initialize(*args)
    if args.flatten.any?
      raise DimensionMismatch unless Vector.vectors_of_same_dimension?(args)
      @dimension = args.flatten.first.dimension
    end
    @dimension ||= 16
    @vectors = args.flatten
  end

  def first(arg = nil)
    if arg
      @vectors.first(arg)
    else
      @vectors.first
    end
  end

  def last
    @vectors.last
  end

  def [](index)
    @vectors[index]
  end

  def each
    @vectors.each
  end

  def <<(other)
    if other.kind_of?(Vector)
      @vectors << other
    else
      raise ArgumentError.new("Vector expected #{other} received.")
    end
  end

  # Returns new Vectors object containing the vectors
  # from self and other
  def +(other)
    Vectors.new(@vectors + other.vectors)
  end

  def sample(*args)
    @vectors.sample(*args)
  end

  def size
    @vectors.size
  end

  def sum
    a = Array.new(dimension, 0)
    inject(Vector.new(a)) do |memo, vector|
      memo += vector
      memo
    end
  end

  def mean
    sum / @vectors.size.to_f
  end

  def label
    @vectors.inject(Hash.new(0)) do |memo, vector|
      memo[vector.label] += 1
      memo
    end.max_by { |label, count| count }.first
  end

  def sort_by! &block
    @vectors.sort_by! &block
  end

  def inject(start, &block)
    @vectors.inject(start, &block)
  end
end

