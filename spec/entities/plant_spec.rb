require 'rspec'
require 'spec_helper'

require 'entity_framework'
require 'systems'

describe 'Plants' do

  before :each do
    @plant = Plant.new(100)
  end

  it 'has energy' do
    @plant[Energy].should_not be_nil
  end

  it 'should do photosynthesis' do
    @plant[Photosynthetic].should_not be_nil
  end

  it 'gains energy when processed by Photosynthesis engine' do
    expect {Photosynthesis.new(Sun.new).process(@plant)}.to change {@plant[Energy].energy_level}
  end
end