class ApplicationJob < ActiveJob::Base

  def self.replace_playlist(current_user)
    log = "#{Time.now}\n"
    spotify_user = RSpotify::User.new(current_user.spo_hash)
    track_ids = Track.select_tracks(current_user.playlist_properties.first)
    if track_ids.present?
      tracks =  RSpotify::Base.find(track_ids, 'track')
      spotify_user.playlists.each do |playlist|
        if playlist.id == current_user.playlist_id
          playlist.replace_tracks!(tracks)
          log += "成功: #{current_user.name}"
        end
      end
    else
      log += "失敗: 該当トラックがありません。"
    end
    File.open(Rails.root.join("log").to_s + "/delayed_job.log", "w") do |f|
      f.write(log)
    end
  end

end
