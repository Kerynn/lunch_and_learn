class Country 
  attr_reader :name,
              :latlong
  
  def initialize(country_data)
    @name = country_data[:name][:common]
    @latlong = country_data[:capitalInfo][:latlng]
  end

  def latitude 
    latlong[0]
  end

  def longitude 
    latlong[1]
  end
end