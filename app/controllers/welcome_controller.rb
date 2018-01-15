class WelcomeController < ApplicationController
  def index
  end

  def update_playlist
    if @current_user.blank? || @current_user.playlist_id.blank?
      redirect_to "/"
      return
    else
      begin
        track_ids = Track.where("release_date >= ?", Time.now - 1.weeks).order(release_date: :desc).map(&:t_id).sample(5)
        tracks =  RSpotify::Base.find(track_ids, 'track')
        spotify_user = RSpotify::User.new(@current_user.spo_hash)
        spotify_user.playlists.each do |playlist|
          if playlist.id == @current_user.playlist_id
            playlist.replace_tracks!(tracks)
          end
        end
      rescue => e
        e.backtrace.each do |err|
          p err
        end
        redirect_to "/", alert: "更新に失敗しました。\nログインし直すか、プレイリストを再登録してください。"
        return
      end

      redirect_to "/", notice: "プレイリストを更新しました。"
    end
  end

end
