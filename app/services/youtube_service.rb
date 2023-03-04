class YoutubeService 

  def self.video_search(country_name)
    parse(conn.get("/youtube/v3/search?q=#{country_name}"))
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'https://www.googleapis.com') do |f|
      f.params['part'] = "snippet"
      f.params['maxResults'] = 1
      f.params['key'] = ENV['youtube_api']
      f.params['channelId'] = 'UCluQ5yInbeAkkeCndNnUhpw'
    end
  end
end