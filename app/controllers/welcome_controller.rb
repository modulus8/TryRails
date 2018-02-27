class WelcomeController < ApplicationController
  def index
    @tracks = Track.where("release_date >= ?", Time.now - 1.weeks).order("RAND()").limit(6)
    @all_played_tracks = Track.where.not(played_at: nil).order(played_at: :desc).limit(20).order("RAND()").limit(4)
    if @current_user.present?
      begin
        spotify_user = RSpotify::User.new(@current_user.spo_hash)
        @recently_played = create_tracks(spotify_user.recently_played(limit: 4), "recently")
      rescue
        @recently_played = nil
      end
    end
  end

  def update_playlist
    if @current_user.blank? || @current_user.playlist_id.blank? || @current_user.playlist_properties.blank?
      redirect_to "/"
      return
    else
      begin
        ApplicationJob.delay.replace_playlist(@current_user)
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
