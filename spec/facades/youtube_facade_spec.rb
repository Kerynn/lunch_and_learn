require 'rails_helper'

RSpec.describe YoutubeFacade do 
  before :each do 
    stub_request(:get, "https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=UCluQ5yInbeAkkeCndNnUhpw&key=#{ENV['youtube_api']}&q=canada&maxResults=1")
      .to_return(status: 200, body: File.read('./spec/fixtures/canada_history_response.json'), headers: {})
  end


  it 'can return the video object' do 
    video = YoutubeFacade.get_video('canada')

    expect(video).to be_an_instance_of(Video)
  end
end 