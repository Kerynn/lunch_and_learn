require 'rails_helper'

RSpec.describe "Get a User's Favorites API" do 
  it "can get a user's favorites" do
    jimjam = User.create!(name: 'Jim Jam', email: 'jimmyjam@example.com', api_key: 'bg98765674dtjft7565467g')
    favorite_1 = jimjam.favorites.create!(country: 'Italy', recipe_link: 'https://cookiesandcups.com/easy-tuscan-chicken-recipe/', recipe_title: 'Tuscan Chicken')
    favorite_2 = jimjam.favorites.create!(country: 'Germany', recipe_link: 'https://www.tasteofhome.com/recipes/german-potato-dumplings/', recipe_title: 'German Potato Dumplings')
    favorite_3 = jimjam.favorites.create!(country: 'Japan', recipe_link: 'https://www.delicious.com.au/recipes/edamame-shichimi-recipe/', recipe_title: 'Edamame Schichimi')

    expect(jimjam.favorites.count).to eq(3)

    get "/api/v1/favorites?api_key=#{jimjam.api_key}"

    expect(response).to be_successful

    favorites = JSON.parse(response.body, symbolize_names: true)

    expect(favorites).to be_a Hash
    expect(favorites).to have_key(:data)
    expect(favorites[:data].count).to eq(3)

    expect(favorites[:data][0][:id]).to eq(favorite_1.id.to_s)
    expect(favorites[:data][1][:id]).to eq(favorite_2.id.to_s)
    expect(favorites[:data][2][:id]).to eq(favorite_3.id.to_s)

    expect(favorites[:data][0][:attributes][:recipe_title]).to eq(favorite_1.recipe_title)
    expect(favorites[:data][0][:attributes][:recipe_link]).to eq(favorite_1.recipe_link)
    expect(favorites[:data][0][:attributes][:country]).to eq(favorite_1.country)
    # expect(favorites[:data][0][:attributes][:created_at]).to eq(favorite_1.created_at.to_s)

    favorites[:data].each do |fav|
      expect(fav).to have_key(:id)
      expect(fav).to have_key(:type)
      expect(fav[:type]).to eq('favorite')
      expect(fav).to have_key(:attributes)
      expect(fav[:attributes]).to be_a Hash
      
      expect(fav[:attributes]).to have_key(:recipe_title)
      expect(fav[:attributes][:recipe_title]).to be_a String

      expect(fav[:attributes]).to have_key(:recipe_link)
      expect(fav[:attributes][:recipe_link]).to be_a String

      expect(fav[:attributes]).to have_key(:country)
      expect(fav[:attributes][:country]).to be_a String

      expect(fav[:attributes]).to have_key(:created_at)
      expect(fav[:attributes][:created_at]).to be_a String

      expect(fav[:attributes]).to_not have_key(:user_id)
      expect(fav[:attributes]).to_not have_key(:updated_at)
    end
  end

  it 'will return no matching user error message if api_key is invalide' do 
    get '/api/v1/favorites?api_key=09879876865tyguyiut7587'

    expect(response).to_not be_successful
    expect(response).to have_http_status(404)

    error_response = JSON.parse(response.body, symbolize_names: true)

    expect(error_response).to have_key(:errors)
    expect(error_response[:errors]).to eq("No matching user for this api_key")
  end

  it 'will return an empty array if user does not have any favorites' do 
    simon = User.create!(name: 'Simon', email: 'simonsays@example.com', api_key: 'jdi99387268dhfh23843847bbhbdf444')

    expect(simon.favorites.count).to eq(0)

    get "/api/v1/favorites?api_key=#{simon.api_key}"

    expect(response).to be_successful

    favorites = JSON.parse(response.body, symbolize_names: true)

    expect(favorites).to be_a Hash
    expect(favorites).to have_key(:data)
    expect(favorites[:data].count).to eq(0)
  end
end