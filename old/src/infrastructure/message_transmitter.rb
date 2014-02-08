module MessageTransmitter

  attr_reader :untransmitted_messages

  def initialize
    @untransmitted_messages = []
  end

  def transmit(message)
    @untransmitted_messages.push message
  end

end