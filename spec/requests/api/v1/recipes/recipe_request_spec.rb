require 'rails_helper'

RSpec.describe "Recipes API" do 
  before :each do 
    stub_request(:get, "https://restcountries.com/v3.1/all")
      .to_return(status: 200, body: File.read('./spec/fixtures/all_countries_response.json'), headers: {})    
  end

  it 'can return recipes without a country name query entered' do 
    get '/api/v1/recipes'

    expect(response).to be_successful
  end

  xit 'can return recipes with a country name query entered' do 
    # get '/api/v1/recipes?country=italy'

  end

  xit 'will return an empty array if no recipe results' do 

  end
end

# make sure to show in tests not returning keys don't need