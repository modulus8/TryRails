class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :current_user


  def create_tracks(spo_tarcks, type="none")
    return_tracks = []
    spo_tarcks.each do |track|
      album = track.album
      t = Track.find_or_create_by(t_id: track.id)
      t.name = track.name
      t.artist_name = track.artists.map{|artist| artist.name}.join(",")
      t.preview_url = track.preview_url
      t.track_number = track.track_number
      t.album_name = album.name
      t.album_id = album.id
      t.album_img_url = album.images[-1]["url"]
      t.release_date = album.release_date.length > 4 ? DateTime.parse(album.release_date) : DateTime.parse(album.release_date + "-01-01")
      case type
        when "recently"
          t.played_at = Time.now
      end
      # analyze
      feature = track.audio_features
      t.track_analyze = TrackAnalyze.new(:track_id => t.id) if t.track_analyze.blank?
      t.track_analyze.key = feature.key
      t.track_analyze.danceability = feature.danceability
      t.track_analyze.energy = feature.energy
      t.track_analyze.speechiness = feature.speechiness
      t.track_analyze.acousticness = feature.acousticness
      t.track_analyze.instrumentalness = feature.instrumentalness
      t.track_analyze.liveness = feature.liveness
      t.track_analyze.valence = feature.valence
      t.track_analyze.duration_ms = feature.duration_ms
      t.track_analyze.save!
      t.save!
      return_tracks << t
    end
    return return_tracks
  end

    private
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  protected

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  # end

end
