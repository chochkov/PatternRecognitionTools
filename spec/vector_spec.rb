require 'spec_helper'

describe Vector do
  it "is initialized through a label and a list of arguments" do
    a = Vector.new({ :label => 8 }, 1, 2)
    a.label.should == 8
    a.elements.first.should == 1
    a.elements.last.should == 2

    a = Vector.new(1, 2, 3)
    a.dimension.should == 3

    a = Vector.new
    a.elements.should == []
    a.label.should == nil
  end

  it "is initialized through a list of vectors and a block" do
    a = Vector.new({ :label => 0 }, 1, 2, 3)
    b = Vector.new({ :label => 0 }, 4, 6, 8)
    c = Vector.new a, b do |x, y|
      x + y
    end
    c.dimension.should == 3
    c.elements[0].should == 5
    c.elements[1].should == 8
    c.elements[2].should == 11
    c.label.should == 0
  end

  it "should accept the given label when constructed from elementwise operation on vectors", do 
    a = Vector.new(1, 2)
    b = Vector.new(4, 6)
    c = Vector.new(3, 5)
    d = Vector.new({:label => 0}, a, b, c) do |x, y, z|
      x + y + z
    end

    d.label.should == 0
    d.dimension.should == 2
    d.elements[0].should == 8
    d.elements[1].should == 13
  end

  it "should calculate Eucledian distance" do
    a = Vector.new(2, 3)
    a.distance(Vector.new(5, 5)).should == Math.sqrt((5 - 2)**2 + (5 - 3)**2)
  end

  it "should do outer products and scalar multiplication" do
    (Vector.new(2, 3) * Vector.new(1, 2)).should == 8
    (Vector.new(2, 3) * 3).should == Vector.new(6, 9)
  end

  it "should sum vectors and preserve common or not nil labels" do
    a = Vector.new(1, 2, 9) + Vector.new({ :label => 0 }, 3, 4, 9)
    a.label.should == 0
    a.elements.should == [ 4, 6, 18 ]

    a = Vector.new({ :label => 0 }, 0, 2) + Vector.new({ :label => 1 }, 0, 2)
    a.label.should == nil
    a.elements.should == [ 0, 4 ]
    
    a = Vector.new({ :label => 0 }, 0, 2) + Vector.new(0, 2)
    a.label.should == 0
    a.elements.should == [ 0, 4 ] 

    a = Vector.new(0, 2) + Vector.new(0, 2)
    a.label.should == nil
    a.elements.should == [ 0, 4 ] 
  end

  it "should sum with a nil label if both labels are different", :focus => false do
    a = Vector.new({ :label => 0 }, 1)
    b = Vector.new({ :label => 1 }, 2)
    c = a + b
    c.label.should == nil
  end

  it "should divide by number" do
    a = Vector.new(4, 6)
    b = a / 2
    b.kind_of?(Vector).should be_true
    b.elements.should == [ 2, 3 ]

    a = Vector.new({ :label => 0 })
    b = a / 2
    b.elements.should == []
    b.label.should == 0
  end

  it "should cluster properly" do
    centroids = [ a = Vector.new(1, 2), b = Vector.new(10, 15), c = Vector.new(100, 150) ]
    Vector.new(5, 5).cluster(centroids).should == a
    Vector.new(11, 30).cluster(centroids).should == b
    Vector.new(99, 200).cluster(centroids).should == c
  end
end

