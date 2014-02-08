require 'rspec'
require 'spec_helper'

require 'entity'
require 'components'

class EnergizedEntity < Entity
  def initialize
    super
    self << Energy.new(100)
  end
end

describe 'Energy' do

  before :each do
    @entity = EnergizedEntity.new
  end

  it 'should should provide an energy level' do
    @entity[Energy].energy_level.should == 100
  end

  it 'should provide behavior' do
    @entity[Energy].energy_level += 100
    @entity[Energy].energy_level.should == 200
  end

  it 'treats each Entity individually if initialize is called' do
    entity1 = EnergizedEntity.new
    entity2 = EnergizedEntity.new
    entity1[Energy].add 100
    entity1[Energy].energy_level.should == 200
    entity2[Energy].energy_level.should == 100
  end
end