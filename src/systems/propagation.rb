require 'entity_framework'

class Propagation

  def initialize(entity_manager)
    @entity_manager = entity_manager
  end

  def process(entity)
    proc = entity[Propagating]
    energy = entity[Energy]
    spawned_entities = []

    if (energy.energy_level >= proc.threshold)
      energy.energy_level -= proc.energy_cost
      spawned_entities = offspring_of(entity)
      @entity_manager.add spawned_entities
    end

    spawned_entities
  end

  private

  def offspring_of(entity)
    Spawning.new(entity).spawn
  end

  class Spawning

    def initialize(entity)
      @entity = entity
      @entity_type = entity.class
      @number_of_offspring = entity[Propagating].number_of_offspring
      @mutation_rate = entity[Propagating].mutation_rate
      @energy_cost = entity[Propagating].energy_cost
    end

    def spawn
      new_ones = []
      @number_of_offspring.times do
        spawned_entity = spawn_one
        new_ones << spawned_entity
      end
      disperse_energy_between new_ones
      new_ones
    end

    def spawn_one
      components_to_mutate = @entity.components
      new_one = @entity_type.new
      new_one.remove_components

      components_to_mutate.each do |component|
        component_type = component.class
        component = if should_mutate(component_type)
                      mutated_component(component, @mutation_rate[component_type])
                    else
                      component.clone
                    end
        new_one << component
      end

      new_one
    end

    def should_mutate(component_type)
      @mutation_rate.has_key? component_type
    end

    def mutated_component(component, mutation_info)
      Mutation.new(component, mutation_info).mutate
    end

    def disperse_energy_between(entities)
      energy_to_give = @energy_cost/entities.size
      entities.each do |e|
        e[Energy].energy_level = energy_to_give
      end
    end
  end

  class Mutation
    def initialize(component, mutation_info)
      @component = component
      @mutation_info = mutation_info
    end

    def mutate
      cloned = @component.clone
      @mutation_info.each do |attribute, mutation|
        current_value = cloned.send(attribute)
        mutated_value = current_value + random_sign * mutation_amount(mutation)
        cloned.send("#{attribute}=", mutated_value)
      end
      cloned
    end

    def random_sign
      rand() > 0.5 ? 1 : -1
    end

    def mutation_amount(mutation)
      rand() * mutation[:max_mutation]
    end
  end

end