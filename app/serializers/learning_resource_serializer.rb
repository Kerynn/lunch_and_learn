class LearningResourceSerializer 
  include JSONAPI::Serializer

  set_id {"null"}
  attributes :country, :video, :images
end