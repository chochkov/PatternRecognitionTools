require 'spec_helper'

describe Vector do
  it "should multiply" do
    a = Vector.new
    [ a.x, a.y ].should == [ 0, 0 ]
  end
end
