class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, uniqueness: true
  serialize :spo_hash

  def self.find_or_create_from_auth(auth)
    self.find_or_create_by(name: auth["id"]) do |user|
      user.email = auth["email"]
      user.password = "spotify"
      user.spo_hash = auth
    end
  end


end
