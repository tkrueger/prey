require_relative "metabolism"
require_relative "organism"
require_relative "location"

class Plant < Organism

  attr_reader :location

  def initialize(location, synthesizer)
    super(location)
    @location = location
    @metabolism = Metabolism.new(initial_energy=100, basic_consumption=1)
    @synthesizer = synthesizer
  end

  def cycle(environment)
    old_energy_level = @metabolism.energy
    @synthesizer.cycle self, environment
    @metabolism.power self
    transmit({type: :EnergyChanged, from: old_energy_level, to: @metabolism.energy})
  end

  def parts
    [@synthesizer]
  end

  def energy
    @metabolism.energy
  end

end