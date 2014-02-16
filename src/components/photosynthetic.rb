require 'entity_framework'

class Photosynthetic < Component

  attr_accessor :efficiency

  def initialize(args={:efficiency => 1})
    super(args)
  end
end