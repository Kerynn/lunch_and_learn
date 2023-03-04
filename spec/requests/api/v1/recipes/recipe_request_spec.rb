require 'rails_helper'

RSpec.describe "Recipes API" do 
  before :each do 
    WebMock.allow_net_connect!
  end

  it 'can return recipes without a country name query entered' do    
    get '/api/v1/recipes'

    expect(response).to be_successful

    recipes = JSON.parse(response.body, symbolize_names: true)

    expect(recipes).to be_a Hash
    expect(recipes).to have_key(:data)
    expect(recipes[:data]).to be_an(Array)

    recipes[:data].each do |recipe|
      expect(recipe).to have_key(:id)
      expect(recipe[:id]).to eq('null')
      expect(recipe).to have_key(:type)
      expect(recipe[:type]).to eq('recipe')
      expect(recipe).to have_key(:attributes)
      expect(recipe[:attributes]).to be_a Hash
      expect(recipe[:attributes]).to have_key(:title)
      expect(recipe[:attributes][:title]).to be_a String
      expect(recipe[:attributes]).to have_key(:url)
      expect(recipe[:attributes][:url]).to be_a String
      expect(recipe[:attributes]).to have_key(:country)
      expect(recipe[:attributes][:country]).to be_a String
      expect(recipe[:attributes]).to have_key(:image)
      expect(recipe[:attributes][:country]).to be_a String

      expect(recipe[:attributes]).to_not have_key(:uri)
      expect(recipe[:attributes]).to_not have_key(:ingredients)
      expect(recipe[:attributes]).to_not have_key(:calories)
    end
  end

  it 'can return recipes with a country name query entered' do 
    get '/api/v1/recipes?country=italy'

    expect(response).to be_successful

    recipes = JSON.parse(response.body, symbolize_names: true)

    expect(recipes).to be_a Hash
    expect(recipes).to have_key(:data)
    expect(recipes[:data]).to be_an(Array)

    expect(recipes[:data][0][:attributes][:title]).to eq('Baked Italy')
    expect(recipes[:data][0][:attributes][:url]).to eq('https://food52.com/recipes/10380-baked-italy')
    expect(recipes[:data][0][:attributes][:country]).to eq('italy')
    expect(recipes[:data][0][:attributes][:image]).to include('https://edamam-product-images.s3.amazonaws.com/web-img/0d8/0d8f382870e658d838cb18c9587558ac.JPG')

    recipes[:data].each do |recipe|
      expect(recipe).to have_key(:id)
      expect(recipe[:id]).to eq('null')
      expect(recipe).to have_key(:type)
      expect(recipe[:type]).to eq('recipe')
      expect(recipe).to have_key(:attributes)
      expect(recipe[:attributes]).to be_a Hash
      expect(recipe[:attributes]).to have_key(:title)
      expect(recipe[:attributes][:title]).to be_a String
      expect(recipe[:attributes]).to have_key(:url)
      expect(recipe[:attributes][:url]).to be_a String
      expect(recipe[:attributes]).to have_key(:country)
      expect(recipe[:attributes][:country]).to be_a String
      expect(recipe[:attributes]).to have_key(:image)
      expect(recipe[:attributes][:country]).to be_a String

      expect(recipe[:attributes]).to_not have_key(:uri)
      expect(recipe[:attributes]).to_not have_key(:ingredients)
      expect(recipe[:attributes]).to_not have_key(:calories)
    end
  end

  it 'will return an empty array if no recipe results' do 
    get '/api/v1/recipes?country='

    expect(response).to be_successful

    recipes = JSON.parse(response.body, symbolize_names: true)
    
    expect(recipes).to be_a Hash
    expect(recipes).to have_key(:data)
    expect(recipes[:data]).to be_an(Array)
    expect(recipes[:data].count).to eq(0)
  end
end

