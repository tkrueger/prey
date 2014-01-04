require 'lib/java_imports'

module Movement

  attr_accessor :speed, :direction

  def initialize
    super
    @speed = 1
    @direction = Vector3f.new(0,0,0)
  end

  def move_for(time)
    @location.add_local(@direction.mult(speed * time))
  end

end