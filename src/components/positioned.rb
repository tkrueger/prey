require 'entity_framework'

class Positioned
  attr_accessor :location

  def initialize(location=Vector3f.new)
    @location = location
  end
end