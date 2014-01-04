require 'rspec'

require 'lib/entity'
require 'lib/location'
require 'lib/java_imports'
java_import "com.jme3.math.Vector3f"

describe 'Location' do

  class LocatedEntity < Entity
    include Location

    def initialize
      super
    end
  end

  describe 'a place to be at' do
    it 'should be given to Entities' do
      LocatedEntity.new.location.should_not be_nil
    end

    it 'can be changed' do
      entity = LocatedEntity.new
      entity.location.add_local(1,2,3).should == Vector3f.new(1,2,3)
    end

  end

  describe 'a facing' do
    it 'should be provided to Entities' do
      LocatedEntity.new.facing.should_not be_nil
    end

    it 'can be changed' do
      entity = LocatedEntity.new
      entity.facing.add_local(1,2,3).should == Vector3f.new(1,2,3)
    end

  end

end