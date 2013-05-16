require_relative "movement"

module Moveable

  def move_for(duration_in_seconds)
    @location = Movement.new(@speed, @direction).away_from(@location).for duration_in_seconds
    transmit({
        type: "Moved",
        to: @location
    })
  end

end