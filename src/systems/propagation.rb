require 'entity_framework'

class Propagation

  def initialize(entity_manager)
    @entity_manager = entity_manager
  end

  def process(entity)
    proc = entity[Propagating]
    energy = entity[Energy]

    if (energy.energy_level >= proc.threshold)
      energy.energy_level -= proc.energy_cost
      proc.number_of_offspring.times do
        new_one = entity.clone
        new_one.components = new_one.components.map {|comp|
          if comp.instance_of?(Energy)
            Energy.new( (proc.energy_cost / proc.number_of_offspring) * rand())
          else
            comp
          end
        }
        @entity_manager.add(new_one)
      end
    end
  end
end