module Mustererkennung
  module VectorClassMethods
    def vectors_of_same_dimension?(*args)
      vector?(args) && same_dimension?(args)
    end

    def vector?(*args)
      args.flatten.any? && args.flatten.all? do |arg|
        arg.kind_of? Vector
      end
    end

    def same_dimension?(*vectors)
      dimension = vectors.flatten.first.dimension
      vectors.flatten.all? do |vector|
        dimension == vector.dimension
      end && dimension
    end

    def elementwise(*vectors)
      dimension = vectors.flatten.first.dimension
      @elements = (0..dimension - 1).inject([]) do |memo, i|
        memo.push yield(*vectors.flatten.map { |vector| vector[i] } )
      end
    end
  end
end

