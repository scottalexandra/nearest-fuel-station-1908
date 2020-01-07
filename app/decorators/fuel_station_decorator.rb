class FuelStationDecorator < SimpleDelegator
  attr_reader :location
  def initialize(fuel_station, location)
    @fuel_station = fuel_station
    @location = location
    super(fuel_station)
  end

  def distance
    directions.distance
  end

  def duration
    directions.duration
  end

  def instructions
    directions.instructions
  end

  private

  def directions
    parsed_directions_data = get_directions_data
    Directions.new(parsed_directions_data)
  end

  def get_directions_data
    raw_directions_data = Faraday.get('https://maps.googleapis.com/maps/api/directions/json') do |req|
      req.params[:origin] = location
      req.params[:destination] = self.address
      req.params[:key] = ENV['GOOGLE_MAPS_API_KEY']
    end

    JSON.parse(raw_directions_data.body, symbolize_names: true)[:routes][0][:legs][0]
  end

end
