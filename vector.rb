class DimensionMismatch < ArgumentError; end

class Vector
	attr_accessor :label, :elements, :dimension
  def initialize(label = nil, *elements)
		elements.flatten!
		@label = label
		@elements = elements
		@dimension = elements.size
  end

	def self.[](*vectors)
		raise DimensionMismatch unless same_dimension?(vectors)
		
		start = Vector.new(label(vectors))

		(0..dimension - 1).inject(start) do |memo, i|
			memo.push yield(*[self[i], *vectors.map { |v| v[i] }])
		end
	end

	def +(other)
		if other.kind_of? Vector
			Vector[self, other] { |x, y| x + y }
		else
			Vector.new(label, map { |e| e + other })
		end
	end

	def -(other)
		if other.kind_of? Vector
			Vector[self, other] { |x, y| x + y }
		else
			Vector.new(label, map { |e| e - other })
		end
	end

	def *(other)
	end

	def /(denominator)
	end

	def label(other = nil)
		if other
			
		else
			@label
		end
	end

	def distance(other)
		Math.sqrt(elementswise(other, 0) { |memo, x, y|
			memo += (x - y) ** 2
		})
	end

	def same_dimension?(*vectors)
		vectors.flatten.all? do |vector|
		  dimension == vector.dimension
		end
	end

	def [](i)
		elements[i]
	end

	def push(*elements)
		self.elements.push(*elements)
		self.dimension += elements.size
		self
	end

	def all?(&block); elements.all? &block; end

	def any?(&block); elements.any? &block; end

	def map(&block); elements.map &block; end

	def elementswise(other, start = Vector.new(label(other)))
		raise DimensionMismatch unless same_dimension?(other)

		(0..dimension - 1).inject(start) do |memo, i|
			yield(memo, self[i], other[i])
		end
	end
end

