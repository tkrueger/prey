require 'rspec'
require 'spec_helper'

require 'systems/metabolism'
require 'entity_framework'

class Procrastination
  attr_accessor :energy_cost, :number_of_offspring
end

describe 'Systems - Cost of living' do

  class Powered

  end

  class APoweredComponent < Powered
  end


  class NonPoweredComponent

  end

  before :each do
    @entity = Entity.new
    @system = Metabolism.new
  end

  it 'only works on entities that own a component type' do
     expect {@system.process @entity}.to raise_error
  end

  it 'changes the entities component data' do
    @entity << Energy.new(100)
    @entity << APoweredComponent.new
    expect { @system.process @entity }.to change{@entity[Energy].energy_level}
  end

  it 'subtracts one energy per component that requires energy' do
    @entity << Energy.new(100)
    @entity << APoweredComponent.new
    @entity << APoweredComponent.new

    expect { @system.process @entity }.to change {@entity[Energy].energy_level}.by -2
  end

end