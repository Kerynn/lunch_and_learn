require 'rails_helper'

RSpec.describe Photo do 
  it 'exists and has attributes' do 
    photo_data = {
      "id": "rknrvCrfS1k",
      "created_at": "2018-01-20T21:28:57Z",
      "updated_at": "2023-03-04T09:03:07Z",
      "promoted_at": "2018-01-21T12:32:39Z",
      "width": 2675,
      "height": 4027,
      "color": "#c0d9f3",
      "blur_hash": "L,H2i[M_oge._4Rjofa}XnbcWAW=",
      "description": "The Cliffs of Cinque Terre",
      "alt_description": "Manarola, Italy",
      "urls": {
          "raw": "https://images.unsplash.com/photo-1516483638261-f4dbaf036963?ixid=Mnw0MTg0NDZ8MHwxfHNlYXJjaHwxfHxpdGFseXxlbnwwfHx8fDE2Nzc5NTMxNTY&ixlib=rb-4.0.3",
          "full": "https://images.unsplash.com/photo-1516483638261-f4dbaf036963?crop=entropy&cs=tinysrgb&fm=jpg&ixid=Mnw0MTg0NDZ8MHwxfHNlYXJjaHwxfHxpdGFseXxlbnwwfHx8fDE2Nzc5NTMxNTY&ixlib=rb-4.0.3&q=80",
          "regular": "https://images.unsplash.com/photo-1516483638261-f4dbaf036963?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=Mnw0MTg0NDZ8MHwxfHNlYXJjaHwxfHxpdGFseXxlbnwwfHx8fDE2Nzc5NTMxNTY&ixlib=rb-4.0.3&q=80&w=1080",
          "small": "https://images.unsplash.com/photo-1516483638261-f4dbaf036963?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=Mnw0MTg0NDZ8MHwxfHNlYXJjaHwxfHxpdGFseXxlbnwwfHx8fDE2Nzc5NTMxNTY&ixlib=rb-4.0.3&q=80&w=400",
          "thumb": "https://images.unsplash.com/photo-1516483638261-f4dbaf036963?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=Mnw0MTg0NDZ8MHwxfHNlYXJjaHwxfHxpdGFseXxlbnwwfHx8fDE2Nzc5NTMxNTY&ixlib=rb-4.0.3&q=80&w=200",
          "small_s3": "https://s3.us-west-2.amazonaws.com/images.unsplash.com/small/photo-1516483638261-f4dbaf036963"
      }
    }

    photo = Photo.new(photo_data)

    expect(photo).to be_an_instance_of(Photo)
    expect(photo.alt_tag).to eq('Manarola, Italy')
    expect(photo.url).to eq('https://images.unsplash.com/photo-1516483638261-f4dbaf036963?ixid=Mnw0MTg0NDZ8MHwxfHNlYXJjaHwxfHxpdGFseXxlbnwwfHx8fDE2Nzc5NTMxNTY&ixlib=rb-4.0.3')
  end
end