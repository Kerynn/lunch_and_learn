require 'rails_helper'

RSpec.describe CountryFacade do 
  before :each do 
    stub_request(:get, "https://restcountries.com/v3.1/all")
      .to_return(status: 200, body: File.read('./spec/fixtures/all_countries_response.json'), headers: {})    
  end

  it 'can return the collection of country result objects' do 
    countries = CountryFacade.get_all_countries

    expect(countries).to be_an Array
    countries.each do |country|
      expect(country).to be_an_instance_of(Country)
    end
  end

  it 'can return one random country object' do 
    random_country = CountryFacade.random_country

    expect(random_country).to be_an_instance_of(Country)
  end

  it 'can return a country object when searched by name' do 
    WebMock.allow_net_connect!

    country = CountryFacade.get_country_info('france')

    expect(country).to be_an_instance_of(Country)
  end
end