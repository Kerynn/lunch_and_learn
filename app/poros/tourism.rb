class Tourism 
  attr_reader :name,
              :address,
              :place_id

  def initialize(tourism_data)
    @name = tourism_data[:properties][:name]
    @address = tourism_data[:properties][:formatted]
    @place_id = tourism_data[:properties][:place_id]
  end
end