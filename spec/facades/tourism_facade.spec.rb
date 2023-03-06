require 'rails_helper'

RSpec.describe TourismFacade do 
  it 'can return a collection of tourism result objects' do 
    WebMock.allow_net_connect!

    tourism_sights = TourismFacade.get_tourist_sights('france')

    expect(tourism_sights).to be_an Array 
    tourism_sights.each do |sight|
      expect(sight).to be_an_instance_of(Tourism)
    end
  end
end