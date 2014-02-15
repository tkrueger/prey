$:.unshift File.join(File.dirname(__FILE__), '../src')

require 'entity_framework'
require 'entities/plant'
require 'java_imports'

java_import 'com.jme3.math.Vector3f'

class Simulation

  attr_accessor :entities, :environment

  def initialize
    @sun = Sun.new
    @photosynthesis = Photosynthesis.new(@sun)
    @environment = Environment.new
    @environment.add Plant.new(100.0, Vector3f.new)
    @propagation = Propagation.new(@environment)
  end

  def step(tpf=20)
    photo = @environment.entities.select {|entity| not entity[Photosynthetic].nil?}
    photo.each { |entity| @photosynthesis.process(entity, tpf) }

    prop = @environment.entities.select {|entity| not entity[Propagating].nil?}
    prop.each {|entity| @propagation.process entity}
  end

  def dump
    @environment.entities.each {|entity| puts entity.inspect}
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
puts "there are now #{sim.environment.number_of_entities} entities"
#sim.dump

