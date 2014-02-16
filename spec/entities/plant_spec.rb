require 'rspec'
require 'spec_helper'

require 'entity_framework'
require 'java_imports'
require 'systems'

describe 'Plants' do

  before :each do
    @plant = Plant.new(:energy_level=>100, :location=>Vector3f.new)
  end

  it 'has energy' do
    @plant[Energy].should_not be_nil
  end

  it 'should do photosynthesis' do
    @plant[Photosynthetic].should_not be_nil
  end

  it 'gains energy when processed by Photosynthesis engine' do
    expect {Photosynthesis.new(Sun.new).process(@plant, 1)}.to change {@plant[Energy].energy_level}
  end
end