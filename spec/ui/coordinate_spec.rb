require_relative '../../src/ui/coordinate'

describe "coordinate" do

  it "takes x and y" do
    Coordinate.new(1,2).x.should equal 1
    Coordinate.new(1,2).y.should equal 2
  end

  it "can offset" do
    Coordinate.new(1,5).offset(1,1).x.should equal 2
    Coordinate.new(1,5).offset(1,1).y.should equal 6

    Coordinate.new(1,5).offset(-1,-1).x.should equal 0
    Coordinate.new(1,5).offset(-1,-1).y.should equal 4
  end

  it "wraps around edges" do
    Coordinate.new(0,0, 10, 10).offset(-1,-1).should eq Coordinate.new(9, 9, 10, 10)
    Coordinate.new(9,9, 10, 10).offset(1,1).should eq Coordinate.new(0, 0, 10, 10)
  end
end