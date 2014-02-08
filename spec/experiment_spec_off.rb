require 'rspec'

require 'ostruct'
require 'uuid'

describe 'Awareness System' do

  class Entity < OpenStruct

    def initialize(id=UUID.generate)
      super
      @id = id
    end

    def add(trait)
      self.extend trait
    end

    def has?(trait)
      self.is_a? trait
    end
  end

  module EnvironmetallyAware

  end

  module Awareness

  end

  class AwarenesSystem
    def work_on(entity)
      entity.noticed_entities = [] unless entity.noticed_entities
      efficiency = entity.sight_efficiency
      entity.environment.each do |other|
        entity.noticed_entities << other
      end
    end
  end

  before :each do
    @entity = Entity.new(1)
    @entity.add(EnvironmetallyAware)
    @entity.add(Awareness)

    @entity_2 = Entity.new(2)
    @entity_3 = Entity.new(3)
  end

  it 'should do something' do
    # let's assume we have two other entities in the area
    @entity.environment = [@entity_2, @entity_3]

    # and then have Awareness do its work
    @entity.should be_a Awareness
    @entity.has?(Awareness).should == true

    AwarenesSystem.new.work_on(@entity)
  end

  it 'with perfect sight, each near entity is detected' do
    @entity.environment = [@entity_2, @entity_3]
    @entity.sight_efficiency = 1

    AwarenesSystem.new.work_on(@entity)
    @entity.noticed_entities.should == [@entity_2, @entity_3]

    puts @entity.inspect
  end
end