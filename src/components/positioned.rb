require 'entity_framework'

require 'java_imports'
java_import 'com.jme3.math.Vector3f'

class Positioned < Component
  attr_accessor :location

  def initialize(args={:location => Vector3f.new})
    super(args)
  end
end