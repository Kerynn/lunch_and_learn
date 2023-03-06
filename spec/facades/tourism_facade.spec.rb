require 'rails_helper'

RSpec.describe TourismFacade do 
  it 'can return a collection of tourism result objects' do
    stub_request(:get, "https://restcountries.com/v3.1/name/france")
    .to_return(status: 200, body: File.read('./spec/fixtures/final_fixtures/france_response.json'), headers: {}) 
    stub_request(:get, "https://api.geoapify.com/v2/places?categories=tourism.sights&filter=circle:2.33,48.87,20000&limit=20&apiKey=#{ENV['places_api_key']}")
      .to_return(status: 200, body: File.read('./spec/fixtures/final_fixtures/tourism_response.json'), headers: {}) 

    tourism_sights = TourismFacade.get_tourist_sights('france')

    expect(tourism_sights).to be_an Array 
    tourism_sights.each do |sight|
      expect(sight).to be_an_instance_of(Tourism)
    end
  end
end