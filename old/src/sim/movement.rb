require_relative "direction"
require_relative "location"

Integer.class_eval do
  def seconds
    self
  end
end

module Math
  def self.to_rad angle
    angle*1.0/180 * Math::PI
  end
end

class Movement
  attr_reader :speed, :direction

  def initialize(speed, direction)
    @direction = direction
    @speed = speed
  end

  def away_from(location)
    @start = location
    self
  end

  def for(duration_in_s)
    new_x = @start.x + @speed.units_per_second * duration_in_s * Math.cos(@direction.radians)
    new_y = @start.y + @speed.units_per_second * duration_in_s * Math.sin(@direction.radians)
    Location.new(new_x, new_y)
  end
end
