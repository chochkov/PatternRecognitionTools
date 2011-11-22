require 'spec_helper'

describe Vectors do
  it "should be initialized with a label and a list of elements" do
    a = Vectors.new(Vector.new(2, 3), Vector.new(3, 4))
    a.first.should == Vector.new(2, 3)
    a.last.should == Vector.new(3, 4)
  end

  it "could be empty" do
    Vectors.new.size == 0
  end

  it "cant be initialized with vectors of different dimensions" do
    lambda {
      Vectors.new(Vector.new(1), Vector.new(-2, 3))
    }.should raise_error(DimensionMismatch)
  end

  it "should correctly give the mean of a collection" do
    a = Vector.new 1, 2
    b = Vector.new 3, 5
    vectors = Vectors.new([a, b])
    m = vectors.mean
    m.kind_of?(Vector).should be_true
    m.elements.should == [ 2, 3.5 ]
  end

  it "should accept new vectors" do
    a = Vectors.new
    a.size.should == 0
    a << Vector.new(2, 3)
    a.size.should == 1
  end

  it "should give the right label" do
    a = Vector.new({ :label => 0 }, 1, 2, 3)
    b = Vector.new({ :label => 0 }, 3, 5, 6)
    c = Vector.new({ :label => 1 }, 4, 4, 4)
    vectors = Vectors.new(a, b, c)
    vectors.label.should == 0

    d = Vector.new({ :label => 1 }, 2, 3, 5)
    e = Vector.new({ :label => 1 }, 2, 3, 5)
    vectors = Vectors.new(a, b, c, d, e)
    vectors.label.should == 1
  end
end

