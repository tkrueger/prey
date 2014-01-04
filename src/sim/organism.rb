require_relative 'moveable'
require_relative '../infrastructure/message_transmitter'

class Organism

  include MessageTransmitter
  include Moveable

  # TODO change to apply(event) and make this a reader
  attr_accessor :location

  def initialize(location)
    super()
    transmit({type: :Born, organism: self, location: location})
  end

  def cycle(seconds)
    puts "organism cycling for #{seconds}s"
  end
end