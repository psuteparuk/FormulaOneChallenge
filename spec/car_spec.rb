require_relative '../model/car'

describe Car do
  let(:car) { Car.new(10, 15, 1, 0.5) }

  context 'initialization' do
    let(:car1) { Car.new(10, 20, 1, 0.8) }
    let(:car2) { Car.new(11, 21, 2, 0.8) }

    it 'should auto-increment id' do
      expect(car1.id).to eq(1)
      expect(car2.id).to eq(2)
    end

    it 'should initialize the position' do
      expect(car1.position).to eq(10)
      expect(car2.position).to eq(11)
    end

    it 'should initialize the speed to zero' do
      expect(car1.speed).to eq(0)
      expect(car2.speed).to eq(0)
    end

    it 'should be running' do
      expect(car1.is_idle).to be(false)
      expect(car2.is_idle).to be(false)
    end
  end

  describe '#move' do
    it 'should not move the car when the car is not running' do
      car.stop
      car.move(2)
      expect(car.position).to eq(10)
      expect(car.speed).to eq(0)
    end

    it 'moves the car to a new position and new speed' do
      car.move(2)
      expect(car.position).to eq(12)
      expect(car.speed).to eq(2)
    end

    it 'should not increase the speed over top speed' do
      car.move(20)
      expect(car.speed).to eq(15)
    end
  end

  describe '#reduce_speed' do
    it 'should not reduce the speed when the car is not running' do
      car.move(10)
      expect(car.speed).to eq(10)
      car.stop
      car.reduce_speed
      expect(car.speed).to eq(10)
    end

    it 'reduces the speed by the handle factor' do
      car.move(10)
      expect(car.speed).to eq(10)
      car.reduce_speed
      expect(car.speed).to eq(5)
    end
  end

  describe '#hit_nitro' do
    it 'should not change speed when the car is not running' do
      car.move(2)
      expect(car.speed).to eq(2)
      car.stop
      car.hit_nitro
      expect(car.speed).to eq(2)
    end

    it 'should double the speed' do
      car.move(2)
      expect(car.speed).to eq(2)
      car.hit_nitro
      expect(car.speed).to eq(4)
    end

    it 'should not increase the speed over top speed' do
      car.move(10)
      expect(car.speed).to eq(10)
      car.hit_nitro
      expect(car.speed).to eq(15)
    end

    it 'should not allow the car the hit nitro more than once' do
      car.move(2)
      expect(car.speed).to eq(2)
      car.hit_nitro
      expect(car.speed).to eq(4)
      car.hit_nitro
      expect(car.speed).to eq(4)
    end
  end

  describe '#stop' do
    it 'should stop the car from running' do
      expect(car.is_idle).to be(false)
      car.stop
      expect(car.is_idle).to be(true)
    end
  end
end
