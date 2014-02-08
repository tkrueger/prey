require 'entity_framework'
require 'entity'

class Plant < Entity
  def initialize(energy_level)
    super()
    self << Energy.new(energy_level)
    self << Photosynthetic.new
  end
end