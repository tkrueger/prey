class MessageBus

  attr_reader :registered_handlers

  def initialize
    @registered_handlers = {}
    @sequence_number = 0
  end

  def transmit(message)
    if message.is_a? Array
      message.each {|msg| transmit_single_message msg }
    else
      transmit_single_message message
    end
  end

  def transmit_single_message(message)
    puts "bus transmitting #{message}"
    message_type = message[:type]
    @registered_handlers[message_type].call(message) unless @registered_handlers[message_type].nil?
  end

  def register(event_type, handler)
    @registered_handlers[event_type] = handler
  end
end