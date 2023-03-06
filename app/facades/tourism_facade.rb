class TourismFacade 

  def self.get_tourist_sights(country_name)
    country_info = CountryFacade.get_country_info(country_name)
    tourist_sights = TourismService.tourism_search(country_info.longitude, country_info.latitude)
    tourist_sights[:features].map do |tourism_info|
      Tourism.new(tourism_info)
    end 
  end
end