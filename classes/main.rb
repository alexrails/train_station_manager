require_relative('train')
require_relative('cargo_train')
require_relative('passenger_train')
require_relative('route')
require_relative('station')
require_relative('carriage')
require_relative('cargo_carriage')
require_relative('passenger_carriage')

class Road

MAIN_MENU = '
             ---------------MENU-----------------
             ------------Choice number------------

             1 - Create Station and other actions
             2 - Create Route and other actions
             3 - Create Train and other actions
             4 - Exit'
STATION_MENU = '
              -----------STATION ACTIONS----------

             1 - Create Station
             2 - Look all stations
             3 - Look all trains of station
             4 - Back to the menu'
ROUTE_MENU = '
              -----------ROUTE ACTIONS----------

             1 - Create Route
             2 - Add waystation to Route
             3 - Look Route
             4 - Back to menu'
TRAIN_MENU = '
             1 - Set Route to Train
             2 - Change Speed
             3 - Stop Train
             4 - Add Carriage
             5 - Del Carriage
             6 - Go to the next Station
             7 - Go to the back Station
             8 - Show Train info
             9 - Back to menu'

def initialize
  @trains = []
  @stations = []
  @routes = []
end

def menu
  loop do
    puts MAIN_MENU
    n = gets.chomp.to_i
    case n
    when 1
      station_actions
    when 2
      route_actions
    when 3
      train_actions
    when 4
      exit
    end
  end
end

def station_actions
  loop do
    puts STATION_MENU
    n = gets.chomp.to_i
    case n
    when 1
      print 'Enter name of Station: '
      station = gets.chomp.to_s
      if @stations.include?(station)
        puts 'This name already exist!'
        station_actions
      else
        @stations << Station.new(station)
        puts "Station - #{@stations.last.name}"
      end
    when 2
      @stations.each { |station| puts "#{station.name}/" }
    when 3
      if @stations.length > 0
        puts 'Enter number of Station'
        @stations.each.with_index { |station, index| puts "#{index} - #{station.name}" }
        number_of_station = gets.chomp.to_i
        @enter_station = @stations[number_of_station]
        @enter_station.show_trains_by_type
      else
        puts 'List of Stations is empty!'
      end
    when 4
      menu
    end
  end
end

def choice_route
  puts 'Choice route from this list: '
  @routes.each.with_index { |route, index| puts "#{index} - #{route}" }
  number_of_route = gets.chomp.to_i
  @enter_route = @routes[number_of_route]
end

def select_station
  @stations.each.with_index { |station, index| puts "#{index} - #{station.name}" }
  puts 'Enter number of  station: '
  @stations[gets.chomp.to_i]
end

def route_actions
  puts ROUTE_MENU
  n = gets.chomp.to_i
  case n
  when 1
    puts 'Choice startstation and finishstation from this list: '
    @start_station = select_station
    @finish_station = select_station
    @routes << Route.new(@start_station, @finish_station)
    puts "Your route is #{@routes.last.show_route}"
  when 2
    choice_route
    puts 'Choice waystation from this list: '
    way_station = select_station
    @enter_route.add_way_station(way_station)
    puts "Your route is #{@enter_route.show_route}"
  when 3
    choice_route
    puts "Your route is #{@enter_route.show_route}"
  when 4
    menu
  end
  route_actions
end

def train_actions
  puts '---------------TRAIN ACTION-------------------'
  puts 'Do You want create new Train?(YES/NO): '
  answer = gets.chomp.to_s.downcase
  if answer == "yes"
    puts 'Enter type of train:
          1 - Passenger train
          2 - Cargo Train'
    type_of_train = gets.chomp.to_i
    puts 'Enter number of train: '
    number_of_train = gets.chomp.to_i

    case type_of_train
    when 1
      @trains << PassengerTrain.new(number_of_train)
    when 2
      @trains << CargoTrain.new(number_of_train)
    end
    @temp_train = @trains.last
    puts "Your Train: #{@temp_train.number} - #{@temp_train.type}"
    other_train_actions
  else
    other_train_actions
  end
end

def other_train_actions
  puts 'Enter number of train for action:'
  @trains.each.with_index { |train, index| puts "#{index} - #{train.number}/#{train.type}" }
  choice = gets.chomp.to_i
  @active_train = @trains[choice]
  puts TRAIN_MENU
  n = gets.chomp.to_i

  case n
  when 1
    train_route
  when 2
    puts 'Enter speed: '
    sp = gets.chomp.to_f
    @active_train.speed_up(sp)
    puts "Current speed - #{@active_train.current_speed}"
  when 3
    @active_train.stop
    puts "Train stopped!"
  when 4
    @active_train.add_carriage(PassengerCarriage.new) if @active_train.type == "passenger"
    @active_train.add_carriage(CargoCarriage.new) if @active_train.type == "cargo"
  when 5
    wagon = @active_train.carriages.last
    @active_train.del_carriage(wagon)    
  when 6
    @active_train.move_forward
    puts "Current station is #{@active_train.location.name}"
  when 7
    @active_train.move_back
    puts "Current station is #{@active_train.location.name}"
  when 8
    puts "Current station is #{@active_train.location.name}"
    puts "Next station is #{@active_train.next_station}"
    puts "Pevious station is #{@active_train.prev_station}"
  when 9
    menu
  end
  other_train_actions
end

def train_route
  if @routes.length > 0
    puts 'Choice route: '
    @routes.each.with_index { |route, index| puts "#{index} - #{route.show_route}" }
    choice = gets.chomp.to_i
    route_of_train = @routes[choice]
    @active_train.add_route(route_of_train)
  else
    puts 'List of routes is empty!'
    menu
  end
end
end

r = Road.new
r.menu