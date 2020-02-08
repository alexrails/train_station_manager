class Route
  include InstanceCounter
  attr_reader :stations, :start_station, :finish_station

  def initialize(start_station, finish_station)
    @start_station = start_station
    @finish_station = finish_station
    @stations = [start_station, finish_station]
    register_instance
  end

  def add_way_station(way_station)
    stations.insert(-2, way_station)
  end

  def del_way_station(way_station)
    stations.delete(way_station)
  end

  def show_route
    stations.each { |station| puts station.name }
  end

end
