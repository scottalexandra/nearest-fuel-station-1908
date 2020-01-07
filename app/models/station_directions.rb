class StationDirections
  attr_reader :distance, :duration, :instructions, :name, :address, :fuel_type, :access_times

  def initialize(directions, station)
    @distance = directions.distance
    @duration = directions.duration
    @instructions = directions.instructions
    @name = station.name
    @address = station.address
    @fuel_type = station.fuel_type
    @access_times = station.access_times
  end
end
