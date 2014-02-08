require_relative "have_like"

RSpec::Matchers.define :a_location_within do |delta_x, delta_y|
  match do |actual|
    delta_x = 0 if delta_x.nil?
    delta_y = 0 if delta_y.nil?
    return false unless actual.respond_to?(:x) && actual.respond_to?(:y)
    (@expected.x-delta_x..@expected.x+delta_x) === actual.x && (@expected.y-delta_y..@expected.y + delta_y) === actual.y
  end

  chain :of do |of|
    @expected = of
  end

  description do
    if delta_x == 0 && delta_y == 0
      text = "a location near #{@expected.inspect}"
    else
      text = "a location within (#{delta_x},#{delta_y}) of #{@expected.inspect}"
    end
    text
  end

  failure_message_for_should do |actual|
    "expected that #{actual} would be a multiple of #{@expected}"
  end
end

RSpec::Matchers.define :have_untransmitted_messages do
  match do |organism|
    organism.should respond_to :untransmitted_messages
    organism.should have_at_least(1).untransmitted_messages
  end
end

RSpec::Matchers.define :contain_message do
  match do |messages|
    matched = messages.find_all do |message|
      @spec.matches message
    end
    !matched.empty?
  end

  chain :like do |message_spec|
    @spec = Specification.new message_spec
  end

  description do
    "to contain a message like #{expected}"
  end
end
