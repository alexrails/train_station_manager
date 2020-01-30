class Station
  attr_accessor :trains
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = {}
  end

  def add_train(train)
    self.trains[train.number] = train
    train.location = self
  end

  def show_trains_on_station
    self.trains.each { |train_numb, train_obj| puts "#{train_numb} : #{train_obj.type}" }
  end

  def show_trains_by_type
    amount_pass = self.trains.count{ |numb, tr_obj| tr_obj.type == "pass" }
    amount_freight = self.trains.count{ |numb, tr_obj| tr_obj.type == "freight" }
    puts "Amount of passenger trains: #{amount_pass}"
    puts "Amount of freight trains: #{amount_freight}"
  end

  def train_departure(train)
    self.trains.delete_if{ |train_numb, train_obj| train_obj == train }
  end
end
