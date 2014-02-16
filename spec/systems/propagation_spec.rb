require 'rspec'
require 'spec_helper'

require 'entity_framework'

describe 'Procrastination' do

  before :each do
    @entity = Entity.new
    @entity << Energy.new(:energy_level => 51)
    @entity << Propagating.new(:energy_cost=>20, :threshold => 50)
    @entity << Positioned.new

    @entity_manager = EntityManager.new
    @entity_manager.add(@entity)
    @system = Propagation.new(@entity_manager)
  end

  it 'does nothing if energy too low' do
    @entity[Energy].energy_level = 49
    @entity[Propagating].threshold = 50
    expect {@system.process @entity}.not_to change { @entity[Energy].energy_level }
  end

  it 'reduces energy when spawning' do
    @entity_manager.number_of_entities.should == 1
    expect {@system.process @entity}.to change { @entity[Energy].energy_level }.by -@entity[Propagating].energy_cost
  end

  it 'produces new entities' do
    expect {@system.process @entity}.to change { @entity_manager.number_of_entities }.by @entity[Propagating].number_of_offspring
  end

  it 'disperses spent energy on spawned entites' do
    @system.process @entity
    @entity_manager.number_of_entities.should == 3

    spawned_entites = @entity_manager.entities.select {|e| e !=  @entity}
    spawned_entites.size.should == 2
    dispersed_energy = spawned_entites.inject(0) {|sum, entity| sum + entity[Energy].energy_level}
    dispersed_energy.should == 20
  end

  it 'stores the generation number in entities' do
    @entity[Propagating].generation.should == 1

    spawned = @system.process @entity
    spawned.size.should == 2
    spawned.each {|offspring| offspring[Propagating].generation.should == 2}
  end

  describe 'mutation' do
    it 'changes component attributes according to mutation info' do
      @entity << Photosynthetic.new
      @system.process @entity
      new_entities = @entity_manager.by_component(Photosynthetic).select {|e|e != @entity}
      new_entities.size.should == 2

      new_entities[0][Photosynthetic].efficiency.should_not == @entity[Photosynthetic].efficiency
    end
  end

  describe 'spreading' do
    it 'should place the offspring at random in interval' do
      @entity[Propagating].spread_min.should == 5
      @entity[Propagating].spread_max.should == 20

      @system.process @entity

      new_entities = @entity_manager.by_component(Positioned).select {|e|e != @entity}
      new_entities.size.should == 2

      new_entities[0][Positioned].location.x.should_not be_within(@entity[Propagating].spread_min-1).of(@entity[Positioned].location.x)
      new_entities[0][Positioned].location.x.should be_within(@entity[Propagating].spread_max).of(@entity[Positioned].location.x)
    end
  end
end