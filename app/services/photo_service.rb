class PhotoService 

  def self.photo_search(country_name)
    parse(conn.get("/search/photos?query=#{country_name}"))
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn 
    Faraday.new(url: 'https://api.unsplash.com') do |f|
      f.params['client_id'] = ENV['unsplash_api_key']
    end
  end
end