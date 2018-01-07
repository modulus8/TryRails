class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :spo_id, uniqueness: true
  serialize :spo_hash

  def self.find_or_create_from_auth(auth)
    self.find_or_create_by(spo_id: auth["id"]) do |user|
      user.name = auth["display_name"].present? ? auth["display_name"] : auth["id"]
      user.email = auth["email"]
      user.password = "spotify"
      user.spo_hash = auth
    end
  end


end
