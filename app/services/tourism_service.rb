class TourismService

  def self.tourism_search(longitude, latitude)
    parse(conn.get("/v2/places?filter=circle:#{longitude},#{latitude},2000"))
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'https://api.geoapify.com') do |f|
      f.params['categories'] = 'tourism.sights'
      f.params['limit'] = 20
      f.params['apiKey'] = ENV['places_api_key']
    end
  end
end