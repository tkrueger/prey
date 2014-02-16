require 'entity_framework'

class Photosynthesis

  def initialize(sun)
    @sun = sun
  end

  def process(entity, t)
    efficiency = entity[Photosynthetic].efficiency
    location = entity[Positioned].location
    sun_intensity = @sun.intensity_at location
    entity[Energy].add sun_intensity * t * efficiency
  end
end