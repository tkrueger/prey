
class Energy < Component

  attr_accessor :energy_level

  def initialize(arguments={:energy_level => 100})
    super(arguments)
  end

  def add(additional_energy)
    @energy_level += additional_energy
  end
end