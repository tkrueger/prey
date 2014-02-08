require_relative "../../src/sim/movement"
require_relative "../../src/sim/speed"
require_relative "../../src/sim/direction"

describe Movement do

  it "takes us to a new position over time" do
    speed = Speed.new(10)
    direction = Direction.new(Math.to_rad 45)
    new_location = Movement.new(speed, direction).away_from(Location.new(100,100)).for(5.seconds)
    expect(new_location.x).to be_within(0.5).of(135)
    expect(new_location.y).to be_within(0.5).of(135)
  end

end