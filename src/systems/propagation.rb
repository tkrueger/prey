require 'entity_framework'

class Propagation

  def initialize(environment)
    @environment = environment
  end

  def process(entity)
    proc = entity[Propagating]
    energy = entity[Energy]

    if (energy.energy_level >= proc.threshold)
      energy.energy_level -= proc.energy_cost
      proc.number_of_offspring.times do
        @environment.add("a spawned entity")
      end
    end
  end
end