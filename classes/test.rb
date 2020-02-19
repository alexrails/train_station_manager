# frozen_string_literal: true

require_relative 'accessors.rb'

class Car
  include Accessors
  attr_accessor_with_history :model, :color
  strong_attr_accessor :age, Integer
end

car = Car.new

car.model = 'lada'
car.model = 'kia'
car.model = 'bmw'
car.age = 5
p car.model_history
p car.age
car.age = 'five'
