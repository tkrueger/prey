require 'rspec'

require 'lib/entity'
require 'lib/energy'

# Traits are just modules
module MyTrait
  attr_accessor :from_trait_1

  def initialize
    super
    @from_trait_1 = "from one"
  end

  def my_trait_method
    true
  end
end

module MyTrait2
  attr_accessor :from_trait_2

  def initialize
    super
    @from_trait_2 = "from two"
  end
end

# normally, Traits are given on Entity type level
class EnergyUsingEntity < Entity
  include Energy

  def initialize
    super
  end
end

describe 'Traits' do

  it 'can ge given to an instance' do
    entity = Entity.new
    entity.extend MyTrait
    entity.should respond_to :my_trait_method
  end

  it 'can ge given to a class' do
    entity = EnergyUsingEntity.new
    entity.should be_a(Energy)
    entity.energy_level.should == 0
  end

  it 'can be detected' do
    EnergyUsingEntity.new.is_a?(Energy).should == true
  end

  it 'can deal with multiple Traits' do
    class MultipleTrait < Entity
      include MyTrait
      include MyTrait2

      def initialize
        super
      end
    end
    MultipleTrait.new.from_trait_1.should == "from one"
    MultipleTrait.new.from_trait_2.should == "from two"
  end
end