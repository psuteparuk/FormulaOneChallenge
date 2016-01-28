require_relative '../model/race'

describe Race do
  context 'initialization' do
    it 'raises error when number of teams input is malformed' do
      expect { Race.new(-1, 100) }.to raise_error(ArgumentError, 'Number of teams has to be a natural number.')
      expect { Race.new(1.5, 100) }.to raise_error(ArgumentError, 'Number of teams has to be a natural number.')
      expect { Race.new('test', 100) }.to raise_error(ArgumentError, 'Number of teams has to be a natural number.')
    end

    it 'raises error when track length input is malformed' do
      expect { Race.new(5, -1) }.to raise_error(ArgumentError, 'Track length has to be greater than 0.')
      expect { Race.new(5, 'test') }.to raise_error(ArgumentError, 'Track length has to be greater than 0.')
    end

    it 'sets the number of teams and track length' do
      race = Race.new(3, 1000)
      expect(race.num_teams).to eq(3)
      expect(race.track_length).to eq(1000)
    end

    it 'aligns the cars correctly' do
      race = Race.new(3, 1000)
      cars = race.cars
      expect(cars[0].position).to eq(0)
      expect(cars[1].position).to eq(-200)
      expect(cars[2].position).to eq(-600)
    end
  end

  describe '#reassess_speed' do
    let(:race) { Race.new(3, 1000) }

    it 'detects cars that are within distance threshold and reduce their speeds' do
      race.step
      expect(race.cars[0].speed).to eq(4)
      expect(race.cars[1].speed).to eq(8)

      stub_const("Race::DISTANCE_THRESH", 200)
      race.reassess_speed # car 1 and 2 are too close with each other -> call reduce speed
      expect(race.cars[0].speed).to eq(3.2)
      expect(race.cars[1].speed).to eq(6.4)
    end

    it 'should let the last car hit nitro' do
      race.step
      expect(race.cars[2].speed).to eq(12)

      race.reassess_speed
      expect(race.cars[2].speed).to eq(24)
    end
  end

  describe '#step' do
    it 'should move the cars by the time step' do
      race = Race.new(2, 1000)
      race.cars.each do |car|
        expect(car).to receive(:move).with(Race::TIME_STEP)
      end
      race.step
    end

    it 'should stop the cars that passed the finish line' do
      race = Race.new(2, 1)
      race.step
      expect(race.cars[0].is_idle).to be(true)
      expect(race.cars[1].is_idle).to be(false)
    end
  end
end
