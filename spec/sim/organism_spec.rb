require 'rspec'

require_relative "../../spec/matchers"
require_relative "../../spec/have_like"

require_relative "../../src/sim/organism"
require_relative "../../src/sim/location"

describe Organism do

  it 'should send a message when born' do
    where_it_was_born = Location.new(100,100)
    organism = Organism.new where_it_was_born
    expect(organism).to have(1).untransmitted_messages
                     .like({
                               :type => "Born",
                               :to => where_it_was_born
                           })
  end

end