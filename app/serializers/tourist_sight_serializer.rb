class TouristSightSerializer 
  include JSONAPI::Serializer

  set_id {"null"}
  attributes :name, :address, :place_id
end