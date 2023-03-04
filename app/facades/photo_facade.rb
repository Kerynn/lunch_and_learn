class PhotoFacade 

  def self.get_photos(country_name)
    photos = PhotoService.photo_search(country_name)
    photos[:results].map do |photo_data|
      Photo.new(photo_data)
    end
  end
end