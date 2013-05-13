require_relative '../../src/sim/plant'
require_relative '../../src/sim/photosynthesizer'
require_relative '../../src/ui/coordinate'

describe "plant" do

  class Environment
    def sunlight_intensity_at(location)
      return 2
    end
  end

  it "when in the sun, it collects energy" do
    environment = Environment.new
    plant = Plant.new(Coordinate.new(50,50), Photosynthesizer.new)
    expect {plant.cycle(environment)}.to change {plant.energy}.by 1
  end
end