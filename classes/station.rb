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
    trains.each do |train_numb, train_obj|
      puts "Train number #{train_numb} : #{train_obj.type}"
    end
  end

  def trains_list
    trains.each { |train_numb, train_obj| yield(train_numb, train_obj) }
  end

  def show_trains_by_type
    amount_pass = trains.count { |_numb, tr_obj| tr_obj.type == "passenger" }
    amount_cargo = trains.count { |_numb, tr_obj| tr_obj.type == "cargo" }
    puts "Amount of passenger trains: #{amount_pass}"
    puts "Amount of freight trains: #{amount_cargo}"
  end

  def train_departure(train)
    trains.delete_if { |_train_numb, train_obj| train_obj == train }
  end

  def add_train(train)
    trains[train.number] = train
    train.location = self
  end

  private

  def validate!
    raise "Name should contains more than 5 symbols!" if name.length < 6
  end
end
