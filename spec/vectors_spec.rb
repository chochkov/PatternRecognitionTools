require 'spec_helper'

describe Vectors do
  it "should be initialized from array of triples each meaning x, y and label" do
    a = Vectors.new([ [1, 2, 8], [3, 4, 0] ])
    a.first.should == Vector.new(1, 2, 8)
    a.last.should == Vector.new(3, 4, 0)
  end

  it "should be initialized from a collection of vectors" do
    a = Vector.new 1, 2
    b = Vector.new 3, 5
    vectors = Vectors.new([a, b])
    vectors.first.should == a
    vectors.last.should == b
  end

  it "could be empty" do
    Vectors.new.size == 0
  end

  it "should correctly give the mean of a collection" do
    a = Vectors.new([ [2, 3, nil], [4, 5, nil] ])
    a.mean.should == Vector.new(3, 4)
    a.mean.should == a.centroid
  end

  it "should accept new vectors" do
    a = Vectors.new
    a.size.should == 0
    a << Vector.new(2, 3)
    a.size.should == 1
  end
end

