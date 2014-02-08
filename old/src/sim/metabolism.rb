class Metabolism

  attr_reader :energy

  def initialize(initial_energy, basic_consumption=0)
    @energy = initial_energy
    @basic_consumption = basic_consumption
  end

  def power(organism)
    organism.parts.each {|part| part.power_from self }
    @energy -= @basic_consumption
  end

  def draw_power(amount)
    @energy -= amount
  end

  def repower_by(amount)
    @energy += amount
  end

  def dead?
    @energy <= 0
  end

end

