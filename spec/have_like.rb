class Specification

  #
  # Describes desired value for specific properties of a hash
  #

  def initialize(spec)
    @spec = spec
  end

  def matches(message)
    unmatched_keys = @spec.keys.find_all do |key|
      if @spec[key].respond_to?( :matches?)
        !@spec[key].matches? message[key]
      else
        message[key] != @spec[key]
      end
    end
    unmatched_keys.empty?
  end

  def to_s
    def text_for(key)
      @spec[key].respond_to?(:description) ? @spec[key].description : "'#{@spec[key]}'"
    end

    txt = "{\n"
    @spec.keys.each do |key|
      txt += "\t#{key}: #{text_for key}\n"
    end
    txt += "}\n"
    txt
  end

end



class HaveLike < RSpec::Matchers::BuiltIn::Have

  #
  # Like 'Have', but extended by a specification for elements to match.
  #
  # Example: @organism.should have(1).untransmitted_messages.like({:type => "OrganismSpawned"})
  #

  def like(spec)
    @spec = Specification.new(spec)
    self
  end

  def matches?(collection_or_owner)
    if @spec
      return matches_spec?(collection_or_owner)
    else
      return super
    end
  end


  def matches_spec?(collection_or_owner)
    collection = determine_collection(collection_or_owner)
    @matched_messages =matched_messages_in collection
    @actual = @matched_messages.length

    case @relativity
      when :at_least then @actual >= @expected
      when :at_most  then @actual <= @expected
      else                @actual == @expected
    end
  end

  def matched_messages_in(messages)
    messages.find_all do |message|
      @spec.matches message
    end
  end

  def failure_message_for_should
    "expected #{relative_expectation} #{@collection_name} matching #{@spec.to_s}, got #{@actual}"
  end

  def failure_message_for_should_not
    super
  end
end

RSpec::Matchers.class_eval do
  def have(expected)
    HaveLike.new(expected)
  end

  def have_at_least(expected)
    HaveLike.new(expected, :at_least)
  end
end
