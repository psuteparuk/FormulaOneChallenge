# Formula-One Challenge

A simulation of a formula-one race. Here are the rules:

In a Formula-1 challenge, there are n teams numbered 1 to n. Each team has a car and a driver.

Car's specification are as follows:
- Top speed: (150 + 10 * i) km per hour
- Acceleration: (2 * i) meter per second square.
- Handling factor (hf) = 0.8
- Nitro : Increases the speed to double or top speed, whichever is less. Can be used only once.

Here i is the team number.

The cars line up for the race. The start line for (i + 1)th car is 200 * i meters behind the ith car.
All of them start at the same time and try to attain their top speed. A re-assessment of the positions is done every 2 seconds(So even if the car has crossed the finish line in between, you'll get to know after 2 seconds). During this assessment, each driver checks if there is any car within 10 meters of his car, his speed reduces to: hf * (speed at that moment). Also, if the driver notices that he is the last one on the race, he uses 'nitro'.

Taking the number of teams and length of track as the input, Calculate the final speeds and the corresponding completion times.

## Usage
You need to have ruby installed on your machine. Download the patch and `bundle install` to install rspec for testing purpose. Run the simulation by command `ruby app.rb <num_teams> <track_length>`.

## Tests
There are unit tests for this program. Simply run `rspec spec`.
