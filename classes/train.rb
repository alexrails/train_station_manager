class Train
  include Company
  include InstanceCounter
  include ValidDefinition
  attr_accessor :speed, :route, :location
  attr_reader :number, :type, :carriages

  NUMBER_EXAMPLE = /^[a-zа-я\d]{3}-?[a-zа-я\d]{2}/i

  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  def initialize(number)
    @number = number
    @type = type
    @speed = 0
    @carriages = []
    @@trains[number] = self
    register_instance
    validate!
  end

  def speed_up(speed)
    self.speed = speed
  end

  alias :current_speed :speed

  def stop
    self.speed = 0
  end

  def del_carriage(carriage)
      self.carriages.delete(carriage) if @speed == 0
  end

   def add_route(route)
    self.route = route
    self.location = route.start_station
    route.start_station.add_train(self)
  end

   def add_carriage(carriage)
    if carriage.type == self.type
      self.carriages << carriage if @speed == 0
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

  def carriages_list
    self.carriages.each.with_index { |carriage, index| yield(carriage, index) }
  end

  private

  def validate!
    raise "Number can't be blank!" if number.nil?
    raise "Number has wrong format!" if self.number !~ NUMBER_EXAMPLE
  end
end
