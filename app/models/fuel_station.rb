class FuelStation
  attr_reader :name, :address, :fuel_type, :access_times

  def initialize(info)
    @name = info[:station_name]
    @address = format_address(info[:street_address], info[:city], info[:state], info[:zip])
    @fuel_type = info[:fuel_type_code]
    @access_times = info[:access_days_time]
  end

  def format_address(street, city, state, zip)
    "#{street} #{city}, #{state} #{zip}"
  end
end
