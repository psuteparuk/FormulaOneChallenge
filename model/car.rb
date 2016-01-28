## Class Car:
#  Handle the states of a car, e.g. position, speed, acceleration.
#  Also handle any changes to the states.

class Car

  @@count = 0 # use for auto-increment id

  def initialize(position, top_speed, acc, hf)
    @id = @@count + 1
    @position = position
    @speed = 0
    @top_speed = top_speed
    @acc = acc
    @hf = hf
    @nitro_used = false
    @running = true
    @@count = @id
  end

  def id
    @id
  end

  def position
    @position
  end

  def speed
    @speed
  end

  # calculate new states after time_step seconds have passed
  def move(time_step)
    return if !@running
    @position += @speed*time_step + 0.5*@acc*time_step*time_step
    @speed += @acc*time_step
    clip_speed
  end

  def reduce_speed
    return if !@running
    @speed *= @hf
  end

  def hit_nitro
    return if !@running || @nitro_used
    @speed *= 2
    clip_speed
    @nitro_used = true
  end

  def stop
    @running = false
  end

  def is_idle
    !@running
  end

  private

  # speed cannot go over top_speed
  def clip_speed
    @speed = [@speed, @top_speed].min
  end

end
