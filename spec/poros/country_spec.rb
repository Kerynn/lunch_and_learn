require 'rails_helper'

RSpec.describe Country do 
  it 'exists and has a name attribute' do 
    country_data = {
      "name": {
        "common": "Gambia",
        "official": "Republic of the Gambia",
        "nativeName": {
            "eng": {
                "official": "Republic of the Gambia",
                "common": "Gambia"
            }
          }
        },
        "capitalInfo": {
          "latlng": [
              48.87,
              2.33
          ]
        }
     }

    country = Country.new(country_data)

    expect(country).to be_an_instance_of(Country)
    expect(country.name).to eq("Gambia")
    expect(country.latlong).to be_an Array
    expect(country.latitude).to eq(48.87)
    expect(country.longitude).to eq(2.33)
  end
end