class Track < ApplicationRecord
  validates :name, presence: true
  validates :t_id, uniqueness: true
  validates :release_date, presence: true
  has_one :track_analyze
  has_many :comments

  def self.select_tracks(property)
    tracks = self.where("release_date >= ?", Time.now - 1.weeks)
    ####################
    case property.style
      when "and"
        tracks = self.and(tracks, property, property.updown)
      when "or"
        tracks = self.or(tracks, property, property.updown)
    end

    return tracks.order(release_date: :desc).map(&:t_id).sample(50)
  end

  private
    def self.return_updown_func(tracks, feature_hash, updown)
      case updown
        when "up"
          p "up#########################"
          p feature_hash[:attr]
          p feature_hash[:property]
          return self.up(tracks, feature_hash)
        when "down"
          p "down#########################"
          p feature_hash[:attr]
          p feature_hash[:property]
          return self.down(tracks, feature_hash)
      end
    end

    def self.and(tracks, property, updown)
      if property.danceability.present?
        tracks = self.return_updown_func(tracks, {"attr": "danceability", "property": property.danceability}, updown)
      end

      if property.energy.present?
        tracks = self.return_updown_func(tracks, {"attr": "energy", "property": property.energy}, updown)
      end

      if property.speechiness.present?
        tracks = self.return_updown_func(tracks, {"attr": "speechiness", "property": property.speechiness}, updown)
      end

      if property.acousticness.present?
        tracks = self.return_updown_func(tracks, {"attr": "acousticness", "property": property.acousticness}, updown)
      end

      if property.instrumentalness.present?
        tracks = self.return_updown_func(tracks, {"attr": "instrumentalness", "property": property.instrumentalness}, updown)
      end

      if property.liveness.present?
        tracks = self.return_updown_func(tracks, {"attr": "liveness", "property": property.liveness}, updown)
      end

      if property.valence.present?
        tracks = self.return_updown_func(tracks, {"attr": "valence", "property": property.valence}, updown)
      end

      if property.duration_ms.present?
        tracks = self.return_updown_func(tracks, {"attr": "duration_ms", "property": property.duration_ms}, updown)
      end

      return tracks
    end

    def self.or(tracks, property, updown)
      track_array = []
      if property.danceability.present?
        track_array << self.return_updown_func(tracks, {"attr": "danceability", "property": property.danceability}, updown).map(&:id)
      end

      if property.energy.present?
        track_array << self.return_updown_func(tracks, {"attr": "energy", "property": property.energy}, updown).map(&:id)
      end

      if property.speechiness.present?
        track_array << self.return_updown_func(tracks, {"attr": "speechiness", "property": property.speechiness}, updown).map(&:id)
      end

      if property.acousticness.present?
        track_array << self.return_updown_func(tracks, {"attr": "acousticness", "property": property.acousticness}, updown).map(&:id)
      end

      if property.instrumentalness.present?
        track_array << self.return_updown_func(tracks, {"attr": "instrumentalness", "property": property.instrumentalness}, updown).map(&:id)
      end

      if property.liveness.present?
        track_array << self.return_updown_func(tracks, {"attr": "liveness", "property": property.liveness}, updown).map(&:id)
      end

      if property.valence.present?
        track_array << self.return_updown_func(tracks, {"attr": "valence", "property": property.valence}, updown).map(&:id)
      end

      if property.duration_ms.present?
        track_array << self.return_updown_func(tracks, {"attr": "duration_ms", "property": property.duration_ms}, updown).map(&:id)
      end

      return Track.where(id: track_array.uniq!)
    end

    def self.up(tracks, feature_hash)
      tracks = tracks.joins(:track_analyze).where("track_analyzes.#{feature_hash[:attr]} >= ?", feature_hash[:property])
      return tracks
    end

    def self.down(tracks, feature_hash)
      tracks = tracks.joins(:track_analyze).where("track_analyzes.#{feature_hash[:attr]} <= ?", feature_hash[:property])
      return tracks
    end

end
