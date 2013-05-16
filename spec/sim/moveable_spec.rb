require_relative "../../spec/matchers"

require_relative "../../src/sim/moveable"
require_relative "../../src/sim/speed"
require_relative "../../src/sim/direction"
require_relative "../../src/infrastructure/message_transmitter"

class Mover

  include Moveable
  include MessageTransmitter

  attr_reader :location

  def initialize(at=Location.new(100,100))
    super()
    @location = at
    @speed = Speed.new(5)
    @direction = Direction.new(Math.to_rad 45)
  end

end

describe Moveable do

  it "gives the ability to move" do
    mover = Mover.new
    expect { mover.move_for(5) }.to change {mover.location}
  end

  it "emits a moved event" do
    where_it_was = Location.new(100,100)
    mover = Mover.new(at=where_it_was)
    mover.move_for(5)
    expect(mover).to have_untransmitted_messages

    expect(mover).to have(1).untransmitted_messages
                    .like({
                              :type => "Moved",
                              :to => a_location_within(20, 20).of(where_it_was)
                          })
  end
end