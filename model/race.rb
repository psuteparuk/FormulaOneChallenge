## Class Race:
#  Manage the race settings and run the simulation.

require_relative 'car'

class Race

  TIME_STEP = 2
  DISTANCE_THRESH = 10

  def initialize(num_teams, track_length)
    raise ArgumentError, 'Number of teams has to be a natural number.' if !num_teams.is_a?(Integer) || num_teams < 1
    raise ArgumentError, 'Track length has to be greater than 0.' if !track_length.is_a?(Numeric) || track_length <= 0

    @num_teams = num_teams.to_i
    @track_length = track_length.to_i
    @finished_times = Array.new(@num_teams)
    @time = 0
    align_cars
  end

  def num_teams
    @num_teams
  end

  def track_length
    @track_length
  end

  def cars
    @cars
  end

  # Main simulation. For each iteration, we adjust the speed of each car,
  # then move it forward by TIME_STEP.
  def run
    @time ||= 0
    @race_finished = false

    while !@race_finished
      reassess_speed
      step
    end
  end

  # Readjust the speeds according to the rules
  def reassess_speed
    # Sort cars by their positions
    cars_by_position = @cars.sort_by { |c| c.position }.reverse

    # race is finished
    if cars_by_position.last.is_idle
      @race_finished = true
      return
    end

    # For each car, check whether there is a car within 10 meters of it.
    # If that's the case, reduce the speed.
    cars_by_position.each_with_index do |car, ind|
      next if car.is_idle

      # respond to close cars
      if ((ind > 0 && cars_by_position[ind-1].position - car.position <= DISTANCE_THRESH) ||
          (ind < @num_teams-1 && car.position - cars_by_position[ind+1].position <= DISTANCE_THRESH))
        car.reduce_speed
      end
    end

    cars_by_position.last.hit_nitro # respond to being last
  end

  def step
    @time += TIME_STEP

    @cars.each do |car|
      next if car.is_idle
      car.move(TIME_STEP)
      # Car has passed the finished line
      if car.position >= @track_length
        @finished_times[car.id-1] = @time
        car.stop
      end
    end
  end

  # Pretty-print for console log
  def display_final_state
    puts 'Car No.      Final Speed      Finished Time'
    @cars.each do |car|
      puts "#{car.id}            #{'%.2f' % car.speed}              #{@finished_times[car.id-1]}"
    end
  end

  private

  # Set the initial positions of the cars
  def align_cars
    @cars = Array.new(@num_teams) do |i|
      position = -100*i*(i+1)
      top_speed = (150 + 10*(i+1)) * 5.0/18 # meter per second
      acceleration = 2*(i+1)
      hf = 0.8

      Car.new(position, top_speed, acceleration, hf)
    end
  end

end
