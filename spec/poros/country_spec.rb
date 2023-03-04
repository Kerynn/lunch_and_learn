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
        }
     }

    country = Country.new(country_data)

    expect(country).to be_an_instance_of(Country)
    expect(country.name).to eq("Gambia")
  end
end