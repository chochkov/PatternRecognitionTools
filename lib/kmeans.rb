require 'open-uri'

class Kmeans
  attr_accessor :data, :k

  FILE_NAME = if File.exists?('./pendigits-training.txt')
      'pendigits-training.txt'
    else
      'http://www.inf.fu-berlin.de/lehre/WS11/ME/uebungen/uebung01/pendigits-training.txt'
    end

  def initialize(k = 3)
    @k = k
    @data = open(FILE_NAME) { |file|
      file.read.split("\n")
    }
  end

  # returns `Hash` structure @data:
  # {
  #   :label1 => [ datensatz1, datensatz2 ... ],
  #   ...
  # }
  def to_means
    data.map(&:split).inject(Hash.new { |hash, key| hash[key] = [] }) do |memo, row|
      memo[row.last.to_i] << Vectors.new(row.first(16).map(&:to_i)).mean
      memo
    end
  end

  def clusterize
    k.times { values.rand() }
  end

  def values
    @data.values
  end

  def labels
    @data.keys
  end
end

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
    elsif other.kind_of Vector
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
end

class Vectors
  include Enumerable
  attr_accessor :data

  def initialize(array)
    @data = array.inject([[]]) do |memo, element|
      if memo.last.size < 2
        memo.last.push(element)
      else
        memo.push([element])
      end
      memo
    end.map { |pair| Vector.new(*pair) }
  end

  def each
    @data.each
  end

  def sum
    @data.inject(Vector.new) do |memo, vector|
      memo += vector
      memo
    end
  end

  def mean
    sum / @data.size
  end
end

