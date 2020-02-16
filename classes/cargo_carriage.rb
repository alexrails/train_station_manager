class CargoCarriage < Carriage
  attr_accessor :volume
  attr_reader :max_volume
  def initialize(volume)
    @volume = volume.to_f
    @max_volume = @volume
    @type = "cargo"
  end

  def take_volume(t_volume)
    @volume - t_volume if t_volume <= @volume
  end

  def taked_volume
    max_volume - volume
  end

  alias free_volume volume
end
