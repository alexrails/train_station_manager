class Train
  attr_accessor :speed, :num_of_cars, :route, :location
  attr_reader :number, :type, :carriages

  def initialize(number)
    @number = number
    @type = type
    @num_of_cars = 0
    @speed = 0
    @carriages = []
  end

  def speed_up(speed)
    self.speed = speed
  end

  alias :current_speed :speed

  def stop
    self.speed = 0
  end

  def del_carriage(carriage)
      self.carriages.delete(carriage)
      self.num_of_cars -= 1 if @speed == 0
  end

   def add_route(route)
    self.route = route
    self.location = route.start_station
    route.start_station.add_train(self)
  end

   def add_carriage(carriage)
    if carriage.type == self.type
      self.carriages << carriage
      self.num_of_cars += 1 if @speed == 0
    else
      puts "Wrong type of carriage!"
    end
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
