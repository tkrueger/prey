
require_relative "../../src/sim/location"

describe Location do

  specify { Location.new(4,5).should respond_to(:x)}
  specify { Location.new(4,5).should respond_to(:y)}

  specify { Location.new(4,5).x.should == 4}
  specify { Location.new(4,5).y.should == 5}

end