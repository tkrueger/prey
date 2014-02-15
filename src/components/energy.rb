
class Energy < Component
  attr_accessor :energy_level

  def initialize(initial_energy_level=100)
    @energy_level = initial_energy_level
  end

  def add(additional_energy)
    @energy_level += additional_energy
  end
end