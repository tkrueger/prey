require_relative "metabolism"

class Plant

  attr_reader :location

  def initialize(location, synthesizer)
    @location = location
    @metabolism = Metabolism.new(initial_energy=100, basic_consumption=1)
    @synthesizer = synthesizer
  end

  def cycle(environment)
    @synthesizer.cycle self, environment
    @metabolism.power self
  end

  def parts
    [@synthesizer]
  end

  def energy
    @metabolism.energy
  end
end