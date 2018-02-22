class TrackAnalyze < ApplicationRecord
  belongs_to :track, dependent: :destroy
end
