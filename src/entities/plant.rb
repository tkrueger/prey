require 'entity_framework'
require 'entity'

require 'java_imports'

class Plant < Entity
  def initialize(args={:energy_level=>100, :location=>Vector3f.new})
    super()
    self << Energy.new({:energy_level => args[:energy_level]})
    self << Photosynthetic.new
    self << Positioned.new({:location => args[:location]})
    self << Propagating.new
  end
end