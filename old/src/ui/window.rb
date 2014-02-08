require 'gosu'
require_relative 'plant'
require_relative 'animal'
require_relative 'coordinate'

class Window < Gosu::Window

    def initialize
      super 20*16, 20*16, false
      self.caption = "Prey Game"
      @entities = []
      5.times do
        @entities << Plant.new(self, Coordinate.new(rand(20*16), rand(100), 20*16, 20*16))
        @entities << Animal.new(self, Coordinate.new(rand(20*16), rand(100), 20*16, 20*16))
      end
    end

    def update
    end

    def draw
      @entities.each do |entity|
        entity.run_around if entity.respond_to? :run_around
      end
      @entities.each &:draw
      sleep 0.5
    end
end

window = Window.new
window.show
