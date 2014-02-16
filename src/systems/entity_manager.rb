require 'entity_framework'

require 'set'
require 'multimap'

class EntityManager
  attr_accessor :entities

  def initialize
    @entities = Set.new
    @entities_by_component = Multimap.new
  end

  def add(entity)
    if entity.instance_of? Array
      entity.each{|e| add e}
      return
    end

    @entities.add entity
    index entity
  end

  def by_component(type)
    @entities_by_component[type]
  end

  def number_of_entities
    @entities.size
  end

  private

  def index(entity)
    entity.components.each {|component| @entities_by_component[component.class] = entity}
  end

end