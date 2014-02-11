require 'rspec'
require 'spec_helper'

require 'entity_framework'

describe 'Procrastination' do

  before :each do
    @entity = Entity.new
    @entity << Energy.new(100)
    @entity << Propagating.new

    @environment = Environment.new
    @environment.add(@entity)
    @system = Propagation.new(@environment)
  end

  it 'does nothing if energy too low' do
    @entity[Energy].energy_level = 49
    @entity[Propagating].threshold = 50
    expect {@system.process @entity}.not_to change { @entity[Energy].energy_level }
  end

  it 'reduces energy when spawning' do
    @entity[Energy].energy_level = 51
    @entity[Propagating].threshold = 50
    @entity[Propagating].energy_cost = 20
    @environment.number_of_entities.should == 1
    expect {@system.process @entity}.to change { @entity[Energy].energy_level }.by -@entity[Propagating].energy_cost
  end

end