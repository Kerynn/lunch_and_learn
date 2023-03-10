class User < ApplicationRecord 
  has_many :favorites 
  
  validates_presence_of :name, :email, :api_key
  validates :email, uniqueness: true
  validates :api_key, uniqueness: true

  def create_api_key
    self.api_key = SecureRandom.hex(13)
  end
end