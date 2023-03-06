require 'rails_helper'

RSpec.describe Tourism do 
  it 'exists and has attributes' do 
    tourism_data = {
        "type": "Feature",
        "properties": {
            "name": "Maison de Chateaubriand",
            "country": "France",
            "country_code": "fr",
            "region": "Metropolitan France",
            "state": "Ile-de-France",
            "county": "Hauts-de-Seine",
            "city": "Châtenay-Malabry",
            "suburb": "La Butte Rouge",
            "quarter": "Robinson",
            "street": "Rue de Chateaubriand",
            "lon": 2.2642505154094605,
            "lat": 48.77268875,
            "formatted": "Maison de Chateaubriand, 87 Rue de Chateaubriand, 92290 Châtenay-Malabry, France",
            "address_line1": "Maison de Chateaubriand",
            "address_line2": "87 Rue de Chateaubriand, 92290 Châtenay-Malabry, France",
            "categories": [
                "tourism.sights"
            ],
            "datasource": {
                "sourcename": "openstreetmap",
                "attribution": "© OpenStreetMap contributors",
                "license": "Open Database Licence",
                "url": "https://www.openstreetmap.org/copyright",
                "raw": {
                    "fee": "full:3;discount:1,5;free:1st sunday of month",
                }
            },
            "place_id": "515d1f5d62721d024059cf1b831ae7624840f00102f901de515805000000009203174d6169736f6e2064652043686174656175627269616e64"
        }
      }

    tourist_sight = Tourism.new(tourism_data)

    expect(tourist_sight).to be_an_instance_of(Tourism)
    expect(tourist_sight.name).to eq('Maison de Chateaubriand')
    expect(tourist_sight.address).to eq('Maison de Chateaubriand, 87 Rue de Chateaubriand, 92290 Châtenay-Malabry, France')
    expect(tourist_sight.place_id).to eq('515d1f5d62721d024059cf1b831ae7624840f00102f901de515805000000009203174d6169736f6e2064652043686174656175627269616e64')
  end
end