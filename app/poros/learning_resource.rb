class LearningResource 
  attr_reader :country,
              :title,
              :youtube_video_id,
              :photo_data

  def initialize(country_name, video_data, photo_data)
    @country = country_name
    @title = video_data.title
    @youtube_video_id = video_data.youtube_video_id
    @photo_data = photo_data
  end

  def video 
    if title.downcase.include?(country)
      video_hash
    else 
      {}
    end
  end

  def video_hash 
    {
      "title": title,
      "youtube_video_id": youtube_video_id
    }
  end

  def images 
    photo_data.map do |photo|
      {
        "alt_tag": photo.alt_tag,
        "url": photo.url
      }
    end
  end
end