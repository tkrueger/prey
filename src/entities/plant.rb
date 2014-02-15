require 'entity_framework'
require 'entity'

class Plant < Entity
  def initialize(energy_level, location)
    super()
    self << Energy.new(energy_level)
    self << Photosynthetic.new
    self << Positioned.new(location)
    self << Propagating.new(100, 120)
  end
end