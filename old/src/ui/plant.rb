require 'gosu'
require_relative 'coordinate'

class PlantUI
  def initialize(window, location)
    @image = Gosu::Image.from_text(window, ".", "Ubuntu", 16, 1, 100, :left)
    @location = location
  end

  def draw()
    @image.draw(@location.x, @location.y, 0)
  end
end