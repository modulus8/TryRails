class MypageController < ApplicationController

  def index
    if @current_user.blank?
      redirect_to "/"
    else
      spotify_user = RSpotify::User.new(@current_user.spo_hash)
      @playlists = spotify_user.playlists

      # 登録済みプレイリスト
      @resigned_playlist = RSpotify::Playlist.find(@current_user.spo_id, @current_user.playlist_id) if @current_user.playlist_id.present?

    end
  end

end
