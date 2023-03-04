require 'rails_helper'

RSpec.describe Video do 
  it 'exists and has attributes' do 
    video_data = {
            "kind": "youtube#searchResult",
            "etag": "LFDX7l6p4834L6f-fefBMFczMCE",
            "id": {
                "kind": "youtube#video",
                "videoId": "e_okM7Mig6s"
            },
            "snippet": {
                "publishedAt": "2019-10-13T18:35:32Z",
                "channelId": "UCluQ5yInbeAkkeCndNnUhpw",
                "title": "A Super Quick History of Canada",
                "description": "Pictures Requiring Attribution: Buzzzsherman: https://en.wikipedia.org/wiki/File:Journal.pone.0001596.g004.png Dylan Kereluk ...",
                "thumbnails": {
                    "default": {
                        "url": "https://i.ytimg.com/vi/e_okM7Mig6s/default.jpg",
                        "width": 120,
                        "height": 90
                    },
                    "medium": {
                        "url": "https://i.ytimg.com/vi/e_okM7Mig6s/mqdefault.jpg",
                        "width": 320,
                        "height": 180
                    },
                    "high": {
                        "url": "https://i.ytimg.com/vi/e_okM7Mig6s/hqdefault.jpg",
                        "width": 480,
                        "height": 360
                    }
                },
                "channelTitle": "Mr History",
                "liveBroadcastContent": "none",
                "publishTime": "2019-10-13T18:35:32Z"
          }
      }

    video = Video.new(video_data)

    expect(video).to be_an_instance_of(Video)
    expect(video.title).to eq('A Super Quick History of Canada')
    expect(video.youtube_video_id).to eq('e_okM7Mig6s')
  end 
end