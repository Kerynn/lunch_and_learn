class Country 
  attr_reader :name 
  
  def initialize(country_data)
    @name = country_data[:name][:common]
  end
end