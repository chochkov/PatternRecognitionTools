require 'spec_helper'

describe Kmeans do
  it "should read the file locally" do
    a = Kmeans.new
    a.data.class.should == Vectors
    a.data.size.should > 1
  end

  it "should cluster" do
    a = Kmeans.new :k => 3
    clusters = a.clusterize
    clusters.class.should == Hash
    clusters.size.should == 3
    clusters.values.first.class.should == Vectors
  end

  it "centroids" do
    a = Kmeans.new :k => 3, :max_iterations => 25
    a.clusterize
    a.centroids.class.should == Hash
    a.centroids.size.should == 25
  end
end

