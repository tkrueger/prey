

class Cycle

  def initialize(timeline, message_bus)
    @timeline = timeline
    @last_cycle = @timeline.now
    @message_bus = message_bus
  end

  def cycle(environment, cyclables)
    cyclables.each do |cyclable|
      cyclable.cycle(environment)
      if cyclable.untransmitted_messages
        cyclable.untransmitted_messages.each {|msg| @message_bus.transmit msg}
        cyclable.clear_untransmitted_messages
      end
    end
  end
end