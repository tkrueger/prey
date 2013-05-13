require 'gosu'
require_relative 'coordinate'

class Animal
  def initialize(window, location)
    @image = Gosu::Image.from_text(window, "x", "Ubuntu", 16, 1, 100, :left)
    @location = location
    @direction = rand(360)
    @speed = rand(10)
  end

  def delta()
    return rand(3) - 1
  end

  def run_around()
    change_direction

    @location = @location.offset(delta(), delta())
  end

  def change_direction
    @direction = (@direction + rand(20) - 10) % 360
  end

  def draw()
    @image.draw(@location.x, @location.y, 0)
  end
end