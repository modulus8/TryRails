class PlaylistProperty < ApplicationRecord
  validates :style, presence: true
  validates :updown, presence: true
  belongs_to :user

end
