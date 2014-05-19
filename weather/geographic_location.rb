class GeographicLocation

  attr_reader :place, :options 

  MAPPINGS_FILE = "#{Rails.root}/config/specifications/marine_locations.yml"

  def initialize place, options = {}
    @place   = extract_location place.to_s.downcase
    @options = options
  end

  def to_s
    place.to_s
  end

private

  def extract_location place
    YAML.load_file( MAPPINGS_FILE )[ place ]
  end

end