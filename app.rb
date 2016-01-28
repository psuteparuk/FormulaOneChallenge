require_relative 'model/race'

# quit unless there are two command line arguments
unless ARGV.length == 2
  puts 'Wrong number of arguments.'
  puts 'USAGE: ./app.rb <number_of_teams> <track_length>'
  exit
end

number_of_teams = ARGV[0].to_i
track_length = ARGV[1].to_i

if !number_of_teams.is_a?(Integer) || number_of_teams < 1
  puts 'Number of teams has to be a natural number.'
  puts 'USAGE: ./app.rb <number_of_teams> <track_length'
  exit
end

if !track_length.is_a?(Numeric) || track_length <= 0
  puts 'Track length has to be greater than 0.'
  puts 'USAGE: ./app.rb <number_of_teams> <track_length>'
  exit
end

race = Race.new(number_of_teams, track_length)
race.run
race.display_final_state
