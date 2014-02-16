require 'entity_framework'
require 'entity'

require 'java_imports'

class Plant < Entity
  def initialize(energy_level=100, location=Vector3f.new)
    super()
    self << Energy.new(energy_level)
    self << Photosynthetic.new
    self << Positioned.new(location)
    self << Propagating.new(100, 120)
  end
end