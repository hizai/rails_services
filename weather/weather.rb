require "weather_conditions"

class Weather < WeatherConditions

  MAPPINGS_FILE = "#{Rails.root}/config/specifications/weather_cities.yml" 

  def current
    OpenStruct.new current_conditions.merge :city => mappings[ place.to_s ]
  end

private

  def current_conditions
    complete[ "current_condition" ].try( :first ) || {}
  end

end

