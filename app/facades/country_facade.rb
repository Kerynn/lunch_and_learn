class CountryFacade 

  def self.get_country_info(country_name)
    country_data = CountryService.country_search(country_name)
    Country.new(country_data[0])
  end

  def self.get_all_countries 
    countries = CountryService.all_countries_search 
    countries.map do |country_data|
      Country.new(country_data)
    end
  end 

  def self.random_country 
    get_all_countries.sample
  end
end