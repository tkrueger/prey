class Propagating
  attr_accessor :energy_cost, :number_of_offspring, :threshold

  def initialize(energy_cost=100, threshold=150, number_of_offspring=2)
    @energy_cost = energy_cost
    @number_of_offspring = number_of_offspring
    @threshold = threshold
  end
end