require 'rspec'

require_relative "../../spec/have_like"
require_relative "../../spec/matchers"

require_relative "../../src/sim/location"
require_relative "../../src/sim/organism"
require_relative "../../src/sim/cycle"

class MockOrganism

  attr_reader :cycle_time_given
  attr_accessor :untransmitted_messages

  def cycle(time)
    @cycled = true
    @cycle_time_given = time
  end

  def called_to_cycle?
    @cycled
  end

end

class MockTimeline
  attr_accessor :now, :seconds_since_answer

  def seconds_since(point_in_time)
    @seconds_since_answer
  end
end

class MockMessageBus
  attr_accessor :transmitted_messages
  def initialize
    @transmitted_messages = []
  end
  def transmit(msg)
    @transmitted_messages.push msg
  end
end

describe Cycle do

  before :each do
    @timeline = MockTimeline.new
    @timeline.seconds_since_answer = 1

    @organisms = [MockOrganism.new(), MockOrganism.new()]
    @cycle = Cycle.new(@timeline, MockMessageBus.new)
    @cycle.cycle(@organisms)
  end

  it 'should cycle all organisms' do
    @organisms.each do |organism|
      organism.should be_called_to_cycle
    end
  end

  it "should give the cycle time" do
    @organisms.each do |organism|
      organism.cycle_time_given.should == @timeline.seconds_since_answer
    end
  end

  describe "organism's events" do

    before :each do
      @timeline = MockTimeline.new
      @timeline.seconds_since_answer = 1

      @msg_1 = {type: 'dummy', nr: 1}
      @msg_2 = {type: 'dummy', nr: 2}

      @organism_1 = MockOrganism.new()
      @organism_1.untransmitted_messages = [@msg_1, @msg_2]

      @organism_2 = MockOrganism.new()
      @organism_2.untransmitted_messages = []

      @message_bus = MockMessageBus.new
      @cycle = Cycle.new(@timeline, @message_bus)
      @organisms = [@organism_1, @organism_2]
      @cycle.cycle(@organisms)
    end

    it "relays events after cycling an organism" do
      @message_bus.transmitted_messages.should include(@msg_1, @msg_2)
    end
  end
end