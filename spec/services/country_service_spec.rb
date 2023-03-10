require 'rails_helper'

RSpec.describe CountryService do 
  before :each do 
    stub_request(:get, "https://restcountries.com/v3.1/all")
      .to_return(status: 200, body: File.read('./spec/fixtures/all_countries_response.json'), headers: {}) 
    stub_request(:get, "https://restcountries.com/v3.1/name/france")
      .to_return(status: 200, body: File.read('./spec/fixtures/final_fixtures/france_response.json'), headers: {}) 
  end

  it 'can return all countries' do 
    response = CountryService.all_countries_search 

    expect(response).to be_an Array
    expect(response[0]).to be_a Hash
    expect(response[0]).to have_key(:name)
    expect(response[0][:name]).to have_key(:common)
    expect(response[0][:name][:common]).to be_a String
    expect(response[0][:name]).to have_key(:official)
    expect(response[0][:name][:official]).to be_a String
    expect(response[0][:name]).to have_key(:nativeName)
    expect(response[0][:name][:nativeName]).to be_a Hash
  end

  it 'can return one country' do 
    response = CountryService.country_search('france')

    expect(response).to be_an Array
    expect(response[0]).to be_a Hash
    expect(response[0]).to have_key(:name)
    expect(response[0][:name]).to have_key(:common)
    expect(response[0][:name][:common]).to be_a String
    expect(response[0][:name]).to have_key(:official)
    expect(response[0][:name][:official]).to be_a String
    expect(response[0][:name]).to have_key(:nativeName)
    expect(response[0][:name][:nativeName]).to be_a Hash
    expect(response[0]).to have_key(:capitalInfo)
    expect(response[0][:capitalInfo]).to have_key(:latlng)
    expect(response[0][:capitalInfo][:latlng]).to be_an Array
  end
end