require 'rails_helper'

RSpec.describe 'Tourism API' do 
  it 'can return the tourist sights by country name query' do 
    stub_request(:get, "https://restcountries.com/v3.1/name/France")
    .to_return(status: 200, body: File.read('./spec/fixtures/final_fixtures/france_response.json'), headers: {}) 
    stub_request(:get, "https://api.geoapify.com/v2/places?categories=tourism.sights&filter=circle:2.33,48.87,2000&limit=20&apiKey=#{ENV['places_api_key']}")
      .to_return(status: 200, body: File.read('./spec/fixtures/final_fixtures/tourism_response.json'), headers: {}) 

    get '/api/v1/tourist_sights?country=France'

    expect(response).to be_successful

    tourist_sights = JSON.parse(response.body, symbolize_names: true)

    expect(tourist_sights).to be_a Hash
    expect(tourist_sights).to have_key(:data)
    expect(tourist_sights[:data]).to be_an Array 

    tourist_sights[:data].each do |sight|
      expect(sight).to have_key(:id)
      expect(sight[:id]).to eq('null')
      expect(sight).to have_key(:type)
      expect(sight[:type]).to eq('tourist_sight')
      expect(sight).to have_key(:attributes)
      expect(sight[:attributes]).to be_a Hash
      expect(sight[:attributes]).to have_key(:name)
      expect(sight[:attributes][:name]).to be_a String
      expect(sight[:attributes]).to have_key(:address)
      expect(sight[:attributes][:address]).to be_a String
      expect(sight[:attributes]).to have_key(:place_id)
      expect(sight[:attributes][:place_id]).to be_a String
    end
  end
end