class Photo 
  attr_reader :alt_tag,
              :url

  def initialize(photo_data)
    @alt_tag = photo_data[:alt_description]
    @url = photo_data[:urls][:raw]
  end
end