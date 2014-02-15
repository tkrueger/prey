require 'rspec'
require 'spec_helper'

require 'entity_framework'

describe 'An Entity Manager' do

  before :each do
    @entity_manager = EntityManager.new
  end
  it 'should be initially empty' do
    @entity_manager.entities.should be_empty
  end

  it 'should take care of new entities ' do
    @entity_manager.add(Entity.new)
    @entity_manager.entities.should_not be_empty
  end

  it 'should be able to give entites by component type' do
    entity1 = Entity.new
    entity1 << Energy.new
    entity2 = Entity.new
    entity3 = Entity.new
    entity3 << Energy.new

    @entity_manager.add([entity1, entity2, entity3])
    @entity_manager.by_component(Energy).should == [entity1, entity3]
  end
end