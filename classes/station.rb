class Station
  include InstanceCounter
  include ValidDefinition
  attr_accessor :trains
  attr_reader :name
  @@all_stations = []

  def self.all
    @@all_stations
  end

  def initialize(name)
    @name = name
    @trains = {}
    @@all_stations << self
    register_instance
    validate!
  end

  def each_trains
    self.trains.each { |train_numb, train_obj| puts "Train number #{train_numb} : #{train_obj.type}" }
  end

  def trains_list
    self.trains.each{ |train_numb, train_obj| yield(train_numb, train_obj) }
  end

  def show_trains_by_type
    amount_pass = self.trains.count{ |numb, tr_obj| tr_obj.type == "passenger" }
    amount_cargo = self.trains.count{ |numb, tr_obj| tr_obj.type == "cargo" }
    puts "Amount of passenger trains: #{amount_pass}"
    puts "Amount of freight trains: #{amount_cargo}"
  end

  def train_departure(train)
    self.trains.delete_if{ |train_numb, train_obj| train_obj == train }
  end

  def add_train(train)
    self.trains[train.number] = train
    train.location = self
  end

  private

  def validate!
    raise "Name should contains more than 5 symbols!" if self.name.length < 6
  end

end
