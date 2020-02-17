# frozen_string_literal: true

class Carriage
  attr_accessor :train, :carriages
  attr_reader :type
  include Company
  def info
    puts "Тип вагона: #{type}, "
  end
end
