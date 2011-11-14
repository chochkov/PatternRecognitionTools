require 'spec_helper'

describe Kmeans do
  it "should read the file locally" do
    a = Kmeans.new
    a.data.class.should == Array
    a.data.size.should > 1
  end

  it "calculate means" do
    a = Kmeans.new.to_means
    a.data.class.should == Hash
    a.data.size.should == 10
  end

  it "should cluster" do
    a = Kmeans.new.to_means
    clusters = a.clusterize
    clusters.class.should == Hash
    clusters.size.should == 3
    clusters.values.first.class.should == Vectors
  end
end

