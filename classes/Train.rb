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
    self.location = route.start_station.name
    route.start_station.add_train(self)
  end

  def move_back
    self.route.stations.each.with_index(-1) do |station, index|
      if self.location == station.name and self.location != route.start_station.name
        station.train_departure(self)
        route.stations[index].add_train(self)
      end
    end
  end

  def move_forward
    self.route.stations.each.with_index(1) do |station, index|
      if self.location == station.name and self.location != route.finish_station.name
        station.train_departure(self)
        route.stations[index].add_train(self)
        break
      end
    end
  end

  def prev_station
    self.route.stations.each.with_index(-1) do |station, index|
      if self.location == station.name and self.location != route.start_station.name
        puts "Preview station is #{route.stations[index].name}"
      end
    end
  end

  def next_station
    self.route.stations.each.with_index(1) do |station, index|
      if self.location == station.name and self.location != route.finish_station.name
        puts "Next station is #{route.stations[index].name}"
      end
    end
  end

end
