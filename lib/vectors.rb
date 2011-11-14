class Vectors
  include Enumerable
  attr_accessor :data

  def initialize(array = [])
    if (array == []) || (array.flatten.first.kind_of? Mustererkennung::Vector)
      @data = array.flatten
      return
    end

    @data = array.inject([[]]) do |memo, element|
      if memo.last.size < 2
        memo.last.push(element)
      else
        memo.push([element])
      end
      memo
    end.map { |pair| Vector.new(*pair) }
  end

  def first
    @data.first
  end

  def last
    @data.last
  end

  def each
    @data.each
  end

  def <<(other)
    @data << other
  end

  def +(other)
    @data + other.data
  end

  def sample(*args)
    @data.sample(*args)
  end

  def size
    @data.size
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
