class ApplicationJob < ActiveJob::Base

  def self.replace_playlist(current_user)
    spotify_user = RSpotify::User.new(current_user.spo_hash)
    track_ids = Track.select_tracks(current_user.playlist_properties.first)
    tracks =  RSpotify::Base.find(track_ids, 'track')
    spotify_user.playlists.each do |playlist|
      if playlist.id == current_user.playlist_id
        playlist.replace_tracks!(tracks)
      end
    end
  end

end
