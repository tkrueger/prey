require 'entity_framework'

class Environment
  attr_accessor :number_of_entities, :entities

  def initialize
    @number_of_entities = 0
    @entities = []
  end

  def add(entity)
    @number_of_entities += 1
    @entities << entity
  end
end