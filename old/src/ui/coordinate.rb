class Coordinate
  attr_reader :x, :y, :max_x, :max_y

  def initialize(x, y, max_x=100, max_y=100)
    @x = x
    @y = y
    @max_x = max_x
    @max_y = max_y
  end

  def offset(delta_x, delta_y)
    @x = clamp(@x + delta_x, @max_x)
    @y = clamp(@y + delta_y, @max_y)
    self
  end

  def clamp(val, max)
    if (val < 0)
      val = max + val
    elsif val >= max
      val = val % max
    end
    val
  end

  def == other
    return  other.x == @x && other.y == @y
  end

  def inspect
    "(#{@x},#{@y})"
  end
end