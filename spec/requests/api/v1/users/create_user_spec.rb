require 'rails_helper'

RSpec.describe 'Create User API' do
  it 'can create a new user' do 
    headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    body = { name: 'Charlie', email: 'goodboy@example.com' }
    post '/api/v1/users', params: body.to_json, headers: headers

    expect(response).to be_successful
    expect(response).to have_http_status(201)

    new_user = User.last 
    created_user_response = JSON.parse(response.body, symbolize_names: true)

    expect(new_user.name).to eq(body[:name])
    expect(new_user.email).to eq(body[:email])

    expect(created_user_response).to have_key(:data)
    expect(created_user_response[:data]).to be_a Hash
    expect(created_user_response[:data]).to have_key(:id)
    expect(created_user_response[:data]).to have_key(:type)
    expect(created_user_response[:data][:type]).to eq('user')
    expect(created_user_response[:data]).to have_key(:attributes)
    expect(created_user_response[:data][:attributes]).to have_key(:name)
    expect(created_user_response[:data][:attributes][:name]).to eq(new_user.name)
    expect(created_user_response[:data][:attributes]).to have_key(:email)
    expect(created_user_response[:data][:attributes][:email]).to eq(new_user.email)
    expect(created_user_response[:data][:attributes]).to have_key(:api_key)
    expect(created_user_response[:data][:attributes][:api_key]).to eq(new_user.api_key)
  end

  it 'will have an error response if email passed is not unique' do 
    existing_user = User.create(name: 'Jim Jam', email: 'jimmyjam@example.com', api_key: 'bg98765674dtjft7565467g')

    headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    body = { name: 'Charles', email: 'jimmyjam@example.com' }
    post '/api/v1/users', params: body.to_json, headers: headers

    expect(response).to_not be_successful
    expect(response).to have_http_status(400)
    expect(response.body).to include('Email has already been taken')
  end

  it 'will have an error response if missing attributes in request' do 
    headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    body = { name: '', email: 'jimmyjam@example.com' }
    post '/api/v1/users', params: body.to_json, headers: headers

    expect(response).to_not be_successful
    expect(response).to have_http_status(400)
    expect(response.body).to include("Name can't be blank")
  end
end