class LearningResourceFacade 

  def self.search_resources(country_name)
    video_details = VideoFacade.get_video(country_name)
    photo_details = PhotoFacade.get_photos(country_name)
    
    LearningResource.new(country_name, video_details, photo_details)
  end
end