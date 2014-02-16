require 'rspec'
require 'spec_helper'
require 'entity_framework'

describe 'Components' do

  class Weight < Component
    attr_accessor :value
    def initialize(args = {:value => 123})
      super(args)
    end
  end

  it 'should have default values' do
    Weight.new.value.should == 123
    Component.new.should_not respond_to :value
  end

  it 'should allow overriding defaults' do
    Weight.new(:value => 66).value.should == 66
  end

  it 'creates accessors if necessary' do
    class DerivedComponent < Component
    end
    DerivedComponent.new(:something_new => 22).should respond_to :something_new
    Component.new.should_not respond_to :something_new
  end
end