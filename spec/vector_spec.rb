require 'spec_helper'

describe Vector do
  it "should do outer products and scalar multiplication" do
    (Vector.new(2, 3) * Vector.new(1, 2)).should == 8
    (Vector.new(2, 3) * 3).should == Vector.new(6, 9)
  end

  it "should divide by number" do
    (Vector.new(4, 6) / 2).should == Vector.new(2, 3)
  end
end

