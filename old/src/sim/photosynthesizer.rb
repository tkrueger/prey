class Photosynthesizer

  def initialize(efficiency=1.0)
    @efficiency = efficiency
  end

  def cycle(organism, environment)
    location = organism.location
    sunlight = environment.sunlight_intensity_at location
    @energy_gain_this_cycle = @efficiency * sunlight
  end

  def power_from(metabolism)
     metabolism.repower_by @energy_gain_this_cycle
  end
end