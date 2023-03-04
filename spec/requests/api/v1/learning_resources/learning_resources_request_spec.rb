require 'rails_helper'

RSpec.describe 'Learning Resource API' do 
  before :each do 
    stub_request(:get, "https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=UCluQ5yInbeAkkeCndNnUhpw&key=#{ENV['youtube_api']}&q=italy&maxResults=1")
      .to_return(status: 200, body: File.read('./spec/fixtures/italy_history_response.json'), headers: {})
    stub_request(:get, "https://api.unsplash.com/search/photos?query=italy&client_id=#{ENV['unsplash_api_key']}")
      .to_return(status: 200, body: File.read('./spec/fixtures/italy_photos_response.json'), headers: {})
    end

  it 'can return the learning resources for the searched country' do 
    get '/api/v1/learning_resources?country=italy'

    expect(response).to be_successful
  end

  xit 'will return max collection of 10 images in response' do 

  end

  xit 'will return an empty hash or array if no video or images found' do 
    # get '/api/v1/learning_resources?country='

  end
end
