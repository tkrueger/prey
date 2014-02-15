class Entity

  attr_accessor :components

  def initialize
    @components = []
  end

  def <<(component)
    @components << component
  end

  def [](component_type = nil)
    all(component_type).first
  end

  def all(component_type = nil)
    return @components if component_type.nil?
    @components.select { |item| item.is_a? component_type}
  end

  alias_method :has, :[]
end