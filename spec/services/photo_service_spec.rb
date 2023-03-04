require 'rails_helper'

RSpec.describe YoutubeService do 
  before :each do 
    stub_request(:get, "https://api.unsplash.com/search/photos?query=italy&client_id=#{ENV['unsplash_api_key']}")
      .to_return(status: 200, body: File.read('./spec/fixtures/italy_photos_response.json'), headers: {})
  end

  it 'can return the searched photo results' do 
    search_query = 'italy'
    response = PhotoService.photo_search(search_query)

    expect(response).to be_a Hash
    expect(response).to have_key(:total)
    expect(response[:total]).to eq(10000)
    expect(response).to have_key(:results)
    expect(response[:results]).to be_an Array
    expect(response[:results].count).to eq(10)

    response[:results].each do |result|
      expect(result).to have_key(:id)
      expect(result).to have_key(:created_at)
      expect(result).to have_key(:description)
      expect(result).to have_key(:alt_description)
      expect(result).to have_key(:urls)
      expect(result[:urls]).to be_a Hash
      expect(result[:urls]).to have_key(:raw)
      expect(result[:urls]).to have_key(:full)
      expect(result[:urls]).to have_key(:regular)
      expect(result).to have_key(:links)
      expect(result[:links]).to be_a Hash
      expect(result).to have_key(:likes)
      expect(result).to have_key(:user)
      expect(result[:user]).to be_a Hash
      expect(result[:user]).to have_key(:id)
      expect(result[:user]).to have_key(:links)
    end
  end
end 