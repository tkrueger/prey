require 'entity_framework'

class Photosynthesis

  def initialize(sun)
    @sun = sun
  end

  def process(entity)
    entity[Energy].add(1)
  end
end