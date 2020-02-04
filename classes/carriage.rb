class Carriage
  attr_accessor :train, :carriages
  attr_reader :type

  def info
    puts "Тип вагона: #{type}, "
  end

end
