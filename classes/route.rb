# frozen_string_literal: true

class Route
  include InstanceCounter
  include Validation
  attr_reader :stations, :start_station, :finish_station

  validate :start_station, :presence
  validate :finish_station, :presence

  def initialize(start_station, finish_station)
    @start_station = start_station
    @finish_station = finish_station
    @stations = [start_station, finish_station]
    register_instance
    validate!
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
