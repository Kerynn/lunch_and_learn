require 'rails_helper'

RSpec.describe 'Learning Resource API' do 
  before :each do 
    stub_request(:get, "https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=UCluQ5yInbeAkkeCndNnUhpw&key=#{ENV['youtube_api']}&q=italy&maxResults=1")
      .to_return(status: 200, body: File.read('./spec/fixtures/italy_history_response.json'), headers: {})
    stub_request(:get, "https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=UCluQ5yInbeAkkeCndNnUhpw&key=#{ENV['youtube_api']}&q=holy see&maxResults=1")
      .to_return(status: 200, body: File.read('./spec/fixtures/italy_history_response.json'), headers: {})
    stub_request(:get, "https://api.unsplash.com/search/photos?query=italy&client_id=#{ENV['unsplash_api_key']}")
      .to_return(status: 200, body: File.read('./spec/fixtures/italy_photos_response.json'), headers: {})
    stub_request(:get, "https://api.unsplash.com/search/photos?query=holy see&client_id=#{ENV['unsplash_api_key']}")
      .to_return(status: 200, body: File.read('./spec/fixtures/holy_see_photos_response.json'), headers: {})
    stub_request(:get, "https://api.unsplash.com/search/photos?query=mystery country&client_id=#{ENV['unsplash_api_key']}")
      .to_return(status: 200, body: File.read('./spec/fixtures/no_photos_response.json'), headers: {})
    stub_request(:get, "https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=UCluQ5yInbeAkkeCndNnUhpw&key=#{ENV['youtube_api']}&q=mystery country&maxResults=1")
      .to_return(status: 200, body: File.read('./spec/fixtures/italy_history_response.json'), headers: {})
    end

  it 'can return the learning resources for the searched country' do 
    get '/api/v1/learning_resources?country=italy'

    expect(response).to be_successful
    
    resources = JSON.parse(response.body, symbolize_names: true)

    expect(resources).to be_a Hash
    expect(resources).to have_key(:data)
    expect(resources[:data]).to be_a Hash 
    expect(resources[:data]).to have_key(:id)
    expect(resources[:data][:id]).to eq('null')
    expect(resources[:data]).to have_key(:type)
    expect(resources[:data][:type]).to eq('learning_resource')
    expect(resources[:data]).to have_key(:attributes)
    expect(resources[:data][:attributes]).to be_a Hash
    expect(resources[:data][:attributes]).to have_key(:country)
    expect(resources[:data][:attributes][:country]).to eq('italy')
    expect(resources[:data][:attributes]).to have_key(:video)
    expect(resources[:data][:attributes][:video]).to be_a Hash
    expect(resources[:data][:attributes][:video]).to have_key(:title)
    expect(resources[:data][:attributes][:video][:title]).to be_a String
    expect(resources[:data][:attributes][:video]).to have_key(:youtube_video_id)
    expect(resources[:data][:attributes][:video][:youtube_video_id]).to be_a String
    expect(resources[:data][:attributes]).to have_key(:images)
    expect(resources[:data][:attributes][:images]).to be_an Array
    
    resources[:data][:attributes][:images].each do |image_info|
      expect(image_info).to have_key(:alt_tag)
      expect(image_info[:alt_tag]).to be_a String
      expect(image_info).to have_key(:url)
      expect(image_info[:url]).to be_a String
    end

    expect(resources[:data][:attributes]).to_not have_key(:snippet)
    expect(resources[:data][:attributes]).to_not have_key(:description)
    expect(resources[:data][:attributes]).to_not have_key(:channelTitle)
    expect(resources[:data][:attributes]).to_not have_key(:created_at)
    expect(resources[:data][:attributes]).to_not have_key(:links)
  end

  it 'will return an empty hash or array if no video or images found' do 
    get '/api/v1/learning_resources?country=holy see'

    expect(response).to be_successful
    
    resources = JSON.parse(response.body, symbolize_names: true)

    expect(resources).to be_a Hash
    expect(resources).to have_key(:data)
    expect(resources[:data]).to be_a Hash 
    expect(resources[:data]).to have_key(:id)
    expect(resources[:data][:id]).to eq('null')
    expect(resources[:data]).to have_key(:type)
    expect(resources[:data][:type]).to eq('learning_resource')
    expect(resources[:data]).to have_key(:attributes)
    expect(resources[:data][:attributes]).to be_a Hash
    expect(resources[:data][:attributes]).to have_key(:country)
    expect(resources[:data][:attributes][:country]).to eq('holy see')
    expect(resources[:data][:attributes]).to have_key(:video)
    expect(resources[:data][:attributes][:video]).to eq({})
    expect(resources[:data][:attributes]).to have_key(:images)
    expect(resources[:data][:attributes][:images]).to be_an Array

    resources[:data][:attributes][:images].each do |image_info|
      expect(image_info).to have_key(:alt_tag)
      expect(image_info).to have_key(:url)
    end

    get '/api/v1/learning_resources?country=mystery country'

    expect(response).to be_successful

    resources = JSON.parse(response.body, symbolize_names: true)

    expect(resources[:data][:attributes]).to have_key(:video)
    expect(resources[:data][:attributes][:video]).to eq({})
    expect(resources[:data][:attributes]).to have_key(:images)
    expect(resources[:data][:attributes][:images]).to be_an Array
    expect(resources[:data][:attributes][:images].count).to eq(0)
  end
end
