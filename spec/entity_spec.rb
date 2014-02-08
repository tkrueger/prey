require 'rspec'
require 'spec_helper'

require 'entity_framework'

describe 'Entity System' do

  class SomeComponent

  end

  before :each do
    @entity = Entity.new
  end
  it 'can have Components added' do
    @entity << Energy.new(100)
  end

  it 'can find components by type' do
    @entity << Energy.new(100)
    @entity[Energy].should_not be_nil
    @entity[SomeComponent].should be_nil
  end

  it 'can give all components' do
    @entity << Energy.new(100)
    @entity << SomeComponent.new
    @entity.all.size.should == 2
  end
end
