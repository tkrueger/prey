require 'src/entity_framework'

class Metabolism
  def process(entity)
    raise "Missing Energy component" unless entity.has Energy
    number_of_components = entity.all(Powered).size
    entity[Energy].energy_level -= number_of_components
  end
end