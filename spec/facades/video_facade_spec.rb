require 'rails_helper'

RSpec.describe VideoFacade do 
  before :each do 
    stub_request(:get, "https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=UCluQ5yInbeAkkeCndNnUhpw&key=#{ENV['youtube_api']}&q=italy&maxResults=1")
      .to_return(status: 200, body: File.read('./spec/fixtures/italy_history_response.json'), headers: {})
  end

  it 'can return the video object' do 
    video = VideoFacade.get_video('italy')

    expect(video).to be_an_instance_of(Video)
  end
end 