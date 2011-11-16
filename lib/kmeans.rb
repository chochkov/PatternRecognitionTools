require './lib/constants'
require 'open-uri'

module Mustererkennung
  class Kmeans
    include Constants

    attr_accessor :data, :k, :clusters, :centroids, :iteration

    def initialize(opts = {})
      @k = opts[:k] || DEFAULT_K

      @data = open(FILE_NAME) do |file|
        file.read.split("\n")
      end.map(&:split).map { |row| row.map(&:to_i) }

      @data.map! do |row|
        vectors = Vectors.new
        row.first(16).each_slice(2) do |x, y|
          vectors << Vector.new(x, y, row.last)
        end
        vectors.mean
      end

      @iteration = 0
      @centroids = { iteration => data.sample(k) }
    end

    def clusterize
      while not convergence? do
        @iteration += 1
        cluster!
      end
      clusters
    end

    # recluster each Vector to the current centroids.
    def cluster!
      @clusters = data.inject(Hash.new { |hash, key| hash[key] = Vectors.new }) do |memo, vector|
        memo[vector.cluster(centroids)] << vector
        memo
      end
    end

    def centroids
      if clusters
        @centroids[iteration] ||= clusters.inject([]) do |memo, pair|
          memo.push(pair.last.centroid)
          memo
        end
      else
        @centroids[0]
      end
    end

    def convergence?
      iteration >= CONVERGENCE_ITERATION
    end
  end
end

