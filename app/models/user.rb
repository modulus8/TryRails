class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :spo_id, uniqueness: true
  serialize :spo_hash
  has_many :playlist_properties

  def self.find_or_create_from_auth(auth)
    user = self.find_or_create_by(spo_id: auth["id"])
    user.name = auth["display_name"].present? ? auth["display_name"] : auth["id"]
    user.email = auth["email"]
    user.password = "spotify"
    user.spo_hash = auth
    user.img_url = auth["images"][-1]["url"]
    user.save!
    return user
  end

  # def self.load_img
  #   if self.img_url.present?
  #     return self.img_url
  #   else
  #     return "/default_user_img.jpeg"
  #   end
  # end

end
