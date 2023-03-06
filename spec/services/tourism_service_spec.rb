require 'rails_helper'

RSpec.describe CountryService do 
  it 'can return the country tourism info' do 
    stub_request(:get, "https://api.geoapify.com/v2/places?categories=tourism.sights&filter=circle:2.33,48.87,2000&limit=20&apiKey=#{ENV['places_api_key']}")
      .to_return(status: 200, body: File.read('./spec/fixtures/final_fixtures/tourism_response.json'), headers: {}) 

    response = TourismService.tourism_search(2.33, 48.87)

    expect(response).to be_a Hash
    expect(response).to have_key(:type)
    expect(response).to have_key(:features)
    expect(response[:features]).to be_an Array

    response[:features].each do |result|
      expect(result).to have_key(:type)
      expect(result).to have_key(:properties)
      expect(result[:properties]).to be_a Hash
      expect(result[:properties]).to have_key(:name)
      expect(result[:properties]).to have_key(:country)
      expect(result[:properties]).to have_key(:formatted)
      expect(result[:properties]).to have_key(:categories)
      expect(result[:properties]).to have_key(:datasource)
      expect(result[:properties]).to have_key(:details)
      expect(result[:properties]).to have_key(:place_id)
      expect(result).to have_key(:geometry)
      expect(result[:geometry]).to have_key(:type)
      expect(result[:geometry]).to have_key(:coordinates)
    end
  end 
end 