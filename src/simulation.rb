
$:.unshift File.join(File.dirname(__FILE__), '../src')

require 'entity_framework'
require 'entities/plant'

class Simulation

  def initialize
    @entities = [Plant.new(100)]
    @sun = Sun.new
    @photosynthesis = Photosynthesis.new(@sun)
  end

  def step()
    photo = @entities.select {|entity| not entity[Photosynthetic].nil?}
    photo.each { |entity| @photosynthesis.process(entity) }
  end

  def dump
    puts @entities[0].inspect
  end
end

sim = Simulation.new
100.times do
  sim.step
end
sim.dump
