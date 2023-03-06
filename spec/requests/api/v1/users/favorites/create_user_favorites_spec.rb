require 'rails_helper'

RSpec.describe 'Create a User Favorite API' do 
  it 'can create a user favorite' do 
    existing_user = User.create(name: 'Jim Jam', email: 'jimmyjam@example.com', api_key: 'bg98765674dtjft7565467g')

    expect(existing_user.favorites.empty?).to be true

    headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    body = { api_key: existing_user.api_key, country: "italy", recipe_link: "http://www.edamam.com/ontologies/", recipe_title: "Spinach and Gouda Lasagna" }
    post '/api/v1/favorites', params: body.to_json, headers: headers

    expect(response).to be_successful
    expect(response).to have_http_status(201)
    expect(existing_user.favorites.empty?).to be false

    success_response = JSON.parse(response.body, symbolize_names: true)

    expect(success_response).to have_key(:success)
    expect(success_response[:success]).to eq("Favorite added successfully")
  end

  it 'will send an error response if no user matches api key' do 
    headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    body = { api_key: '09879876865tyguyiut7587', country: "italy", recipe_link: "http://www.edamam.com/ontologies/", recipe_title: "Spinach and Gouda Lasagna" }
    post '/api/v1/favorites', params: body.to_json, headers: headers

    expect(response).to_not be_successful
    expect(response).to have_http_status(404)

    error_response = JSON.parse(response.body, symbolize_names: true)

    expect(error_response).to have_key(:errors)
    expect(error_response[:errors]).to eq("No matching user for this api_key")
  end

  it 'will send an error if not able to create a user favorite' do 
    existing_user = User.create(name: 'Jim Jam', email: 'jimmyjam@example.com', api_key: 'bg98765674dtjft7565467g')

    expect(existing_user.favorites.empty?).to be true

    headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    body = { api_key: existing_user.api_key, country: "", recipe_link: "http://www.edamam.com/ontologies/", recipe_title: "" }
    post '/api/v1/favorites', params: body.to_json, headers: headers

    expect(response).to_not be_successful
    expect(response).to have_http_status(400)
    expect(existing_user.favorites.empty?).to be true

    error_response = JSON.parse(response.body, symbolize_names: true)

    expect(error_response).to have_key(:errors)
    expect(error_response[:errors]).to eq("Country can't be blank and Recipe title can't be blank")
  end
end