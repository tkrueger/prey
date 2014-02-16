$:.unshift File.join(File.dirname(__FILE__), '../src')

require 'entity_framework'
require 'entities/plant'
require 'java_imports'

java_import 'com.jme3.math.Vector3f'

class Simulation

  attr_accessor :entities, :entity_manager

  def initialize
    @entity_manager = EntityManager.new
    @sun = Sun.new
    @photosynthesis = Photosynthesis.new(@sun)
    @environment = Environment.new
    @entity_manager.add Plant.new(100.0, Vector3f.new)
    @propagation = Propagation.new(@entity_manager)
  end

  def step(tpf=20)
    @entity_manager.by_component(Photosynthetic).each { |entity| @photosynthesis.process(entity, tpf) }
    @entity_manager.by_component(Propagating).each {|entity| @propagation.process entity}
  end

  def dump
    @entity_manager.entities.each {|entity| puts entity.inspect}
  end
end

require 'benchmark'
puts "starting up"
sim = Simulation.new
num_cycles = 20000
start = Time.now
num_cycles.times do
  sim.step(20.0)
end
finish = Time.now
time_in_ms = (finish - start) * 1000
puts "ran #{num_cycles} cycles. Took #{time_in_ms} ms, that is #{time_in_ms / num_cycles} ms per cycle."
puts "there are now #{sim.entity_manager.number_of_entities} entities"
sim.dump

