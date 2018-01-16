class PlaylistProperty < ApplicationRecord
  validates :style, presence: true
  validates :updwon, presence: true
  belongs_to :user

end
