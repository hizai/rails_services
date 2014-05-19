require "weather_conditions"

class Marine < WeatherConditions

private

  def weather
    complete[ "weather" ].first 
  end

end