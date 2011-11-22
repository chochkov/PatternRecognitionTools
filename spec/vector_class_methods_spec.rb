describe "Vector class methods" do
  describe "Vector.same_dimension_vectors?" do
    it "should be true for same dimensions vectors" do
      a = Vector.new 0, 1, 2
      b = Vector.new 9, 2, 4
      Vector.same_dimension?(a, b).should == 3
      Vector.same_dimension?([a, b]).should be_true

      c = Vector.new({:label => 0}, 3, 4, 6)
      Vector.same_dimension?(a, c).should == 3
    end

    it "" do
      Vector.same_dimension?(Vector.new 0, 1).should == 2
    end

    it "should be false for different dimensions" do
      a = Vector.new({:label => 0}, 0, 1, 2)
      b = Vector.new 9, 2, 4, 6
      Vector.same_dimension?(a, b).should be_false
    end
  end

  describe "Vector.vector?" do
    it "should be true for vectors and false otherwise" do
      Vector.vector?(Vector.new).should be_true
      Vector.vector?.should be_false
      Vector.vector?([ 2, 3 ]).should be_false
    end
  end
end
