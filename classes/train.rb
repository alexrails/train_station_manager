class Train
  attr_accessor :speed, :num_of_cars, :route, :location
  attr_reader :number, :type

  def initialize(number, type, num_of_cars)
    @number = number
    @type = type
    @num_of_cars = num_of_cars
    @speed = 0
  end

  def speed_up(speed)
    self.speed = speed
  end

  alias :current_speed :speed

  def stop
    self.speed = 0
  end

  def del_cars
    self.num_of_cars -= 1 if @speed == 0
  end

  def add_cars
    self.num_of_cars += 1 if @speed == 0
  end

  def add_route(route)
    self.route = route
    self.location = route.start_station
    route.start_station.add_train(self)
  end

  def move_back
    location.train_departure(self)
    prev_station.add_train(self)
  end

  def move_forward
    location.train_departure(self)
    next_station.add_train(self)
  end

  def prev_station
    index_st = self.route.stations.index(self.location) - 1
    route.stations[index_st] if self.location.name != route.start_station.name
  end

  def next_station
    index_st = self.route.stations.index(self.location) + 1
    route.stations[index_st] if self.location.name != route.finish_station.name
  end

end
