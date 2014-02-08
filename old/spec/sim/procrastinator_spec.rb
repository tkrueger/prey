require 'ap'
require_relative '../have_like'
require_relative '../../spec/matchers'
require_relative '../../src/ui/coordinate'

require_relative '../../src/sim/metabolism'

class Procrastinator

  attr_reader :threshold, :number_of_offspring, :energy_per_offspring

  def initialize(threshold, number_of_offspring=1, energy_per_offspring=20)
    @threshold = threshold
    @number_of_offspring = number_of_offspring
    @energy_per_offspring = energy_per_offspring
  end

  def cycle(organism, environment)
    @just_spawned = false
    spawn(organism, environment) unless organism.energy < @threshold
  end

  def spawn(organism, environment)
    @just_spawned = true
    @number_of_offspring.times do
      organism.transmit({
          :type => 'OrganismSpawned',
          :location => Coordinate.new(10,10)
      })
    end
  end

  def power_from(metabolism)
    metabolism.draw_power(@number_of_offspring * @energy_per_offspring) if @just_spawned
  end
end

class MockOrganism
  attr_accessor :energy, :untransmitted_messages, :location

  include MessageTransmitter

  def initialize(location=Coordinate.new(6,10))
    super()
    @location = location
  end
end

describe Procrastinator do

  describe "without enough energy" do

    before :each do
      @organism = MockOrganism.new()
      @organism.energy = 10
      @proc = Procrastinator.new(threshold=20)
    end

    it 'does not procrastinate if threshold not met' do
      @proc.cycle(@organism, nil)
      @organism.should_not have_untransmitted_messages
    end
  end

  describe "with enough energy" do

    before :each do
      @organism = MockOrganism.new()
      @organism.energy = 100
      @proc = Procrastinator.new(threshold=20, number_of_offspring=2, energy_per_offspring=20)
    end

    it 'spawns offspring' do
      @proc.cycle(@organism, nil)
      @organism.untransmitted_messages.should contain_message.like({:type => "OrganismSpawned"})
    end

    it "spawns a fixed number of organisms" do
      @proc.cycle(@organism, nil)
      @organism.should have(@proc.number_of_offspring).untransmitted_messages.like({:type => "OrganismSpawned"})
    end

    it "reduces energy by offspring_energy*number_of_offspring" do
      metabolism = Metabolism.new(100)
      @proc.cycle(@organism, nil)
      expect { @proc.power_from metabolism }.to change{metabolism.energy}.from(100).to(60)
    end

    pending "places offspring near organism in environment" do
      @proc.cycle(@organism, nil)
      @organism.should have(@proc.number_of_offspring).untransmitted_messages
                       .like({
                                 :type => "OrganismSpawned",
                                 :location => a_location_near(@organism.location) # TODO install loc in organism
                             })
    end
  end

end
