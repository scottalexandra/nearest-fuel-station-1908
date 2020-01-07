class SearchResults
  attr_reader :location

  def initialize(location)
    @location = location
  end

  def stations
    parsed_fuel_data = get_fuel_info
    fuel_station = FuelStation.new(parsed_fuel_data)
    destination = fuel_station.address
    parsed_directions_data = get_directions_data(destination)
    directions = Directions.new(parsed_directions_data)
    StationDirections.new(directions, fuel_station)
  end

  def get_directions_data(destination)
    raw_directions_data = Faraday.get('https://maps.googleapis.com/maps/api/directions/json') do |req|
      req.params[:origin] = location
      req.params[:destination] = destination
      req.params[:key] = ENV['GOOGLE_MAPS_API_KEY']
    end
    JSON.parse(raw_directions_data.body, symbolize_names: true)[:routes][0][:legs][0]
  end

  def get_fuel_info
    raw_fuel_data = Faraday.get("https://developer.nrel.gov/api/alt-fuel-stations/v1/nearest.json") do |req|
      req.params[:location] = location
      req.params[:limit] = 1
      req.params[:type] = 'ELEC'
      req.headers['x-api-key'] = ENV['NREL_API_KEY']
    end

    JSON.parse(raw_fuel_data.body, symbolize_names: true)[:fuel_stations][0]
  end
end
