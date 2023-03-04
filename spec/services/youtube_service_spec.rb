require 'rails_helper'

RSpec.describe YoutubeService do 
  before :each do 
    stub_request(:get, "https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=UCluQ5yInbeAkkeCndNnUhpw&key=#{ENV['youtube_api']}&q=canada&maxResults=1")
      .to_return(status: 200, body: File.read('./spec/fixtures/canada_history_response.json'), headers: {})
  end

  it 'can return the searched youtube results' do
    search_query = 'canada'
    response = YoutubeService.video_search(search_query)

    expect(response).to be_a Hash
    expect(response).to have_key(:kind)
    expect(response).to have_key(:etag)
    expect(response).to have_key(:items)
    expect(response[:items]).to be_an Array
    expect(response[:items].count).to eq(1)
    expect(response[:items][0]).to have_key(:kind)
    expect(response[:items][0]).to have_key(:id)
    expect(response[:items][0][:id]).to have_key(:kind)
    expect(response[:items][0][:id]).to have_key(:videoId)
    expect(response[:items][0]).to have_key(:snippet)
    expect(response[:items][0][:snippet]).to be_a Hash
    expect(response[:items][0][:snippet]).to have_key(:channelId)
    expect(response[:items][0][:snippet]).to have_key(:title)
    expect(response[:items][0][:snippet][:title]).to include(search_query.capitalize)
    expect(response[:items][0][:snippet]).to have_key(:description)
    expect(response[:items][0][:snippet]).to have_key(:channelTitle)
  end
end 
