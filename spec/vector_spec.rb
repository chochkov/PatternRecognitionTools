require 'spec_helper'

describe Vector do
  it "can be initialized" do
    a = Vector.new(1, 2, 8)
    a.label.should == 8
    a.x.should == 1
    a.y.should == 2
    a = Vector.new
    a.x.should == nil
    a.y.should == nil
    a.label.should == nil
    Vector.new(*[ 1, 2 ]).should == Vector.new(1, 2)
  end

  it "should calculate Eucledian distance" do
    a = Vector.new(2, 3)
    a.distance(Vector.new(5, 5)).should == Math.sqrt((5 - 2)**2 + (5 - 3)**2)
  end

  it "should do outer products and scalar multiplication" do
    (Vector.new(2, 3) * Vector.new(1, 2)).should == 8
    (Vector.new(2, 3) * 3).should == Vector.new(6, 9)
  end

  it "should sum vectors and preserve labels" do
    a = Vector.new(1, 2, 9) + Vector.new(3, 4, 9)
    a.should == Vector.new(4, 6, 9)
    a = Vector.new(1, 2) + Vector.new(3, 4, 9)
    a.label.should == 9
    a = Vector.new(1, 2, 9) + Vector.new(3, 4)
    a.label.should == 9
  end

  it "should divide by number" do
    (Vector.new(4, 6) / 2).should == Vector.new(2, 3)
  end

  it "should cluster properly" do
    centroids = [ a = Vector.new(1, 2), b = Vector.new(10, 15), c = Vector.new(100, 150) ]
    Vector.new(5, 5).cluster(centroids).should == a
    Vector.new(11, 30).cluster(centroids).should == b
    Vector.new(99, 200).cluster(centroids).should == c
  end
end

