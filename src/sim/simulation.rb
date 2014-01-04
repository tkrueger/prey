require_relative "organism"
require_relative "location"
require_relative "message_bus"
require_relative "cycle"
require_relative "timeline"
require_relative "photosynthesizer"
require_relative "plant"

class Environment

  def initialize(message_bus)
    register_with message_bus
    @organisms = []
  end

  def register_with message_bus
    message_bus.register :Born, method(:organism_born)
  end

  def organism_born(message)
    puts "an Organism was born: #{message}"
    @organisms.push(message[:organism])
  end

  def sunlight_intensity_at(location)
    2
  end
end

class Simulation

  def initialize
    @message_bus = MessageBus.new
    @environment = Environment.new(@message_bus)
    @timeline = Timeline.new
    @organisms = Array.new(10) { Plant.new(Location.new(rand(100), rand(100)), Photosynthesizer.new) }
    @message_bus.transmit(@organisms.collect(&:untransmitted_messages).flatten)
    @organisms.map(&:clear_untransmitted_messages)
  end

  def run
    10.times do
      Cycle.new(@timeline, @message_bus).cycle(@environment, @organisms)
    end
  end
end

if __FILE__ == $0
  simulation = Simulation.new
  simulation.run
end