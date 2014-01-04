require_relative "java_imports"

java_import "com.jme3.math.Vector3f"

module Location
  attr_accessor :location, :facing

  def initialize
    super
    @location = Vector3f.new(0,0,0)
    @facing = Vector3f.new(0,0,0)
  end
end