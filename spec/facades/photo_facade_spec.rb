require 'rails_helper'

RSpec.describe PhotoFacade do 
  before :each do 
    stub_request(:get, "https://api.unsplash.com/search/photos?query=italy&client_id=#{ENV['unsplash_api_key']}")
      .to_return(status: 200, body: File.read('./spec/fixtures/italy_photos_response.json'), headers: {})
  end

  it 'can return a collection of photo objects' do 
    photos = PhotoFacade.get_photos('italy')

    expect(photos).to be_an Array
    photos.each do |photo|
      expect(photo).to be_an_instance_of(Photo)
    end
  end
end 