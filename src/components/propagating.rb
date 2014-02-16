class AttributeMutation
  attr_accessor :max_mutation, :meta_mutation

  def initialize(max_mutation, meta_mutation)
    @max_mutation = max_mutation
    @meta_mutation = meta_mutation
  end
end

class MutationReate
  attr_accessor :component, :mutations

  def initialize(component, mutations)
    @component = component
    @mutations = mutations
  end

  def each_attribute(&block)
    mutations.keys.each {|mutation| yield mutation, mutations[mutation]}
  end
end

class Propagating
  attr_accessor :energy_cost, :number_of_offspring, :threshold, :mutation_rate

  def initialize(energy_cost=100, threshold=150, number_of_offspring=2)
    @energy_cost = energy_cost
    @number_of_offspring = number_of_offspring
    @threshold = threshold

    @mutation_rate = {
        Photosynthetic => {
          :efficiency => {
              :max_mutation => 0.5,
              :meta_mutation => 0.5
          }
        }
    }


  end
end