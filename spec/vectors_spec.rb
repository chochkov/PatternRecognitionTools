require 'spec_helper'

describe Vectors do
  it "should correctly give the mean of a collection" do
    Vectors.new([ 2, 3, 3, 4, 4, 5 ]).mean.should == Vector.new(3, 4)
    a = Vectors.new([ Vector.new(2, 3), Vector.new(1, 2) ])
    a.size.should == 2
    a.first.class.should == Vector
  end

  it "should accept new vectors" do
    a = Vectors.new
    a.size.should == 0
    a << Vector.new(2, 3)
    a.size.should == 1
  end
end

