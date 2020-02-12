class PassengerCarriage < Carriage
attr_accessor :seats
attr_reader :max_seats
  def initialize(seats)
    @seats = seats.to_i
    @max_seats = @seats
    @type = "passenger"
  end

  def take_seat
   @seats = @seats - 1 if @seats != 0
  end

  def make_seat
    @seats += 1 if seats < max_seats
  end

  def amount_taked_seats
    max_seats - seats
  end

  def amount_free_seats
    seats
  end
end

