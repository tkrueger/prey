class Entity

  attr_accessor :components

  def initialize
    @components = []
  end

  def <<(component)
    assert_is_component component
    @components << component
  end

  def [](component_type = nil)
    all(component_type).first
  end

  def all(component_type = nil)
    return @components if component_type.nil?
    @components.select { |item| item.is_a? component_type}
  end

  def remove_components
    @components = []
  end

  alias_method :has, :[]

  private

  def assert_is_component(component)
    raise "argument is not a Component instance: #{component}" unless component.is_a? Component
  end
end