require "weather_conditions_related/world_weather"
require "weather_conditions_related/redis_storable"

class WeatherConditions

  include RedisStorable

  DATA_SOURCE = WorldWeather

  attr_reader :place, :options

  def initialize place, options = {}
    @place   = place
    @options = options.merge :q => place.to_s
  end

  def measure!
    redis_store redis_store_key do
      DATA_SOURCE.new( class_name, options ).request
    end
  end

  def complete
    redis_retrieve( redis_store_key, :as => :hash ).try( :[], "data" ) || {}
  end

protected

  def class_name
    self.class.name.underscore.to_sym
  end

  def mappings
    @mappings ||= YAML.load_file self.class::MAPPINGS_FILE
  end

  def redis_store_key
    :"#{ class_name }_#{ place }_measure"
  end

end