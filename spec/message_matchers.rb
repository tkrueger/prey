
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
