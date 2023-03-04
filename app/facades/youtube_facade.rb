class YoutubeFacade 

  def self.get_video(country_name)
    video_data = YoutubeService.video_search(country_name)
    Video.new(video_data[:items][0])
  end
end