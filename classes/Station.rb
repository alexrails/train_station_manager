class Station
  attr_accessor :trains
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = {}
  end

  def add_train(train)
    self.trains[train.number] = train
    train.location = self.name
  end

  def show_trains_on_station
    self.trains.each { |key, val| puts "#{key} : #{val.type}" }
  end

  def show_trains_by_type
    amount_pass = 0
    amount_freight = 0
    self.trains.each do |key, val|
      amount_pass += 1 if "#{val.type}" == "pass"
      amount_freight += 1 if "#{val.type}" == "freight"
    end
    puts "Amount of passenger trains: #{amount_pass}"
    puts "Amount of freight trains: #{amount_freight}"
  end

  def train_departure(train)
    self.trains.delete_if{ |key, val| val == train }
  end
end
