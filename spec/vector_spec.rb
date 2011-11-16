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

  it "should do outer products and scalar multiplication" do
    (Vector.new(2, 3) * Vector.new(1, 2)).should == 8
    (Vector.new(2, 3) * 3).should == Vector.new(6, 9)
  end

  it "should sum vectors" do
    a = Vector.new(1, 2) + Vector.new(3, 4)
    a.should == Vector.new(4, 6)
  end

  it "should divide by number" do
    (Vector.new(4, 6) / 2).should == Vector.new(2, 3)
  end
end

