
# Trait 'energy', giving the same to Entities
module Energy

  attr_reader :energy_level

  def initialize
    @energy_level = 0
  end

  def add_energy amount
    @energy_level += amount
  end
end