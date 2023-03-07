require 'rails_helper'

RSpec.describe LearningResourceFacade do 
  before :each do 
    stub_request(:get, "https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=UCluQ5yInbeAkkeCndNnUhpw&key=#{ENV['youtube_api']}&q=italy&maxResults=1")
      .to_return(status: 200, body: File.read('./spec/fixtures/italy_history_response.json'), headers: {})
    stub_request(:get, "https://api.unsplash.com/search/photos?query=italy&client_id=#{ENV['unsplash_api_key']}")
      .to_return(status: 200, body: File.read('./spec/fixtures/italy_photos_response.json'), headers: {})
    stub_request(:get, "https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=UCluQ5yInbeAkkeCndNnUhpw&key=#{ENV['youtube_api']}&q=holy see&maxResults=1")
      .to_return(status: 200, body: File.read('./spec/fixtures/italy_history_response.json'), headers: {})
    stub_request(:get, "https://api.unsplash.com/search/photos?query=holy see&client_id=#{ENV['unsplash_api_key']}")
      .to_return(status: 200, body: File.read('./spec/fixtures/holy_see_photos_response.json'), headers: {})
    end

  it 'can return the learning resource object' do 
    learning_resource = LearningResourceFacade.search_resources('italy')

    expect(learning_resource).to be_an_instance_of(LearningResource)
    expect(learning_resource.country).to eq('italy')
    expect(learning_resource.video).to be_a Hash
    expect(learning_resource.video).to eq(
        {
            :title=>"A Super Quick History of Italy", 
            :youtube_video_id=>"DD4wjwaFU-U"
        })
    expect(learning_resource.images).to be_an Array
    expect(learning_resource.images.count).to eq(10)
  end

  it 'will return an empty hash if searched country does not return a result' do 
    learning_resource = LearningResourceFacade.search_resources('holy see')

    expect(learning_resource).to be_an_instance_of(LearningResource)
    expect(learning_resource.country).to eq('holy see')
    expect(learning_resource.video).to be_a Hash
    expect(learning_resource.video).to eq({})
    expect(learning_resource.images).to be_an Array
  end
end 
