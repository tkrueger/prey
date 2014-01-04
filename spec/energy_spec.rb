require 'rspec'

require './entity'
require './energy'

class EnergizedEntity < Entity
  include Energy

  def initialize
    super
  end
end

describe 'Energy' do

  it 'should should provide an energy level' do
    EnergizedEntity.new.energy_level.should == 0
  end

  it 'should provide behavior' do
    entity = EnergizedEntity.new
    entity.add_energy 100
    entity.energy_level.should == 100
  end

  it 'treats each Entity individually if initialize is called' do
    entity1 = EnergizedEntity.new
    entity2 = EnergizedEntity.new
    entity1.add_energy 100
    entity1.energy_level.should == 100
    entity2.energy_level.should == 0
  end
end