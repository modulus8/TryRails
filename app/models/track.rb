class Track < ApplicationRecord
  validates :name, presence: true
  validates :t_id, uniqueness: true
  validates :release_date, presence: true
  has_one :track_analyze
end
