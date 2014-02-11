require 'entity_framework'

class Environment
  attr_accessor :number_of_entities

  def initialize
    @number_of_entities = 0
  end

  def add(entity)
    @number_of_entities += 1
  end
end