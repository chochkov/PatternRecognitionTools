require 'open-uri'

module Mustererkennung
  class Kmeans
    attr_accessor :data, :k

    FILE_NAME = if File.exists?('./../examples/pendigits-training.txt')
        './../examples/pendigits-training.txt'
      else
        'http://www.inf.fu-berlin.de/lehre/WS11/ME/uebungen/uebung01/pendigits-training.txt'
      end

    def initialize(k = 3)
      @k = k
      @data = open(FILE_NAME) { |file|
        file.read.split("\n")
      }
      self.to_means
    end

    # returns `Hash` structure @data:
    # {
    #   :label1 => [ datensatz1, datensatz2, ... ],
    #   ...
    # }
    def to_means
      @data = data.map(&:split).inject(Hash.new { |hash, key| hash[key] = [] }) do |memo, row|
        memo[row.last.to_i] << Vectors.new(row.first(16).map(&:to_i)).mean
        memo
      end
      self
    end

    def clusterize(times = 10)
      times.times do
        @clusters = clusters
      end
      @clusters
    end

    def clusters
      values.data.inject(Hash.new { |hash, key| hash[key] = Vectors.new }) do |memo, vector|
        memo[cluster(vector)] << vector
        memo
      end
    end

    def cluster(vector)
      means.inject({}) do |m, mean|
        m[mean] = vector.distance(mean)
        m
      end.min_by { |k, v| v }.first
    end

    def means
      if @clusters
        @clusters.inject([]) do |memo, pair|
          memo.push(pair.last.sample)
          memo
        end
      else
        values.sample(k)
      end
    end

    def values
      Vectors.new(@data.values)
    end

    def labels
      @data.keys
    end
  end
end

