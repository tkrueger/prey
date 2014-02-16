require 'rspec'
require 'spec_helper'

require 'entity_framework'

describe 'Photosynthesis' do

  before :each do
    @entity = Entity.new
    @entity << Positioned.new
    @entity << Energy.new
    @entity << Photosynthetic.new
  end

  describe 'efficiency' do
    it 'should default to 1' do
      puts @entity.inspect
      @entity[Photosynthetic].efficiency.should == 1
    end

    it 'is applied per milisecond duration' do
      sun = Sun.new
      expect { Photosynthesis.new(sun).process(@entity, 1000) }.to change {@entity[Energy].energy_level}.by 1
      expect { Photosynthesis.new(sun).process(@entity,    1) }.to change {@entity[Energy].energy_level}.by 0.001

      @entity[Photosynthetic].efficiency = 0.5
      expect { Photosynthesis.new(sun).process(@entity, 1000) }.to change {@entity[Energy].energy_level}.by 0.5
    end

  end
end