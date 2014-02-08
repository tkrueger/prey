require_relative '../../src/sim/metabolism'

describe Metabolism do

  class EnergyConsumptor

    attr_accessor :energy_per_cycle

    def initialize(energy_per_cycle)
      @energy_per_cycle = energy_per_cycle
    end

    def power_from(metabolism)
      metabolism.draw_power @energy_per_cycle
    end
  end

  class Organism
    attr_reader :parts

    def initialize
      @parts = [EnergyConsumptor.new(5)]
    end
  end

  it "lets parts consume energy" do
    organism = Organism.new
    metabolism = Metabolism.new(100)

    expect {metabolism.power(organism) }.to change  {metabolism.energy}.by -5
  end

  it "survives with enough energy" do
    organism = Organism.new
    metabolism = Metabolism.new(51)

    metabolism.power(organism)
    metabolism.should_not be_dead
  end

  it "dies when all energy is gone" do
    organism = Organism.new
    metabolism = Metabolism.new(5)

    metabolism.power(organism)
    metabolism.should be_dead
  end

  it "has a minimum energy consumption" do
    organism = Organism.new
    metabolism = Metabolism.new(initial_energy=20, base_consumption=2)
    expect {metabolism.power(organism)}.to change {metabolism.energy}.by -7
  end
end