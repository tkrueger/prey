require 'rspec'
require 'lib/movement'
require 'lib/location'
require 'lib/java_imports'

describe 'Movement' do

  class Mover
    include Movement
    include Location

    def initialize
      super
    end
  end

  it 'should change the location in the direction of facing' do
    mover = Mover.new
    mover.location = Vector3f.new(1,0,0)
    mover.direction = Vector3f.new(0,1,0)

    mover.move_for(1)
    mover.location.should == Vector3f.new(1,1,0)

    mover.move_for(0.5)
    mover.location.should == Vector3f.new(1,1.5,0)
  end
end