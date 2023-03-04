class CountryService

  def self.all_countries_search
    parse(conn.get('/v3.1/all'))
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'https://restcountries.com')
  end
end