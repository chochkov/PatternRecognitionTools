# A collection of 2 dimensional vectors
class Vectors
  include Enumerable
  attr_accessor :data

  def initialize(array = [], label = nil)
    @data = if array.empty? || array.all? { |e| e.kind_of? Vector }
        array
      elsif array.all? { |e| e.size == 2 }
        array.map { |pair| Vector.new *pair, label }
      elsif array.all? { |e| e.size == 3 }
        array.map { |triple| Vector.new *triple }
      else
        raise ArgumentError.new "#{array} given, expected vectors or triplets"
      end
  end

  def first
    @data.first
  end

  def last
    @data.last
  end

  def [](count)
    @data[count]
  end

  def each
    @data.each
  end

  def <<(other)
    if other.kind_of?(Vector)
      @data << other
    else
      raise ArgumentError.new("Vector expected #{other} received.")
    end
  end

  # Returns new Vectors object containing the vectors
  # from self and other
  def +(other)
    Vectors.new(@data + other.data)
  end

  def sample(*args)
    @data.sample(*args)
  end

  def size
    @data.size
  end

  def sum
    @data.inject(Vector.new(0, 0)) do |memo, vector|
      memo += vector
      memo
    end
  end

  def mean
    sum / @data.size
  end

  alias :centroid :mean

  def sort_by! &block
    @data.sort_by! &block
  end
end

