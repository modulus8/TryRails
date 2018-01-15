class MypageController < ApplicationController
  before_action :check_current_user

  def index
    spotify_user = RSpotify::User.new(@current_user.spo_hash)
    # 登録済みプレイリスト
    @registered_playlist = RSpotify::Playlist.find(@current_user.spo_id, @current_user.playlist_id) if @current_user.playlist_id.present?
    @playlists_hash = {}
    spotify_user.playlists.each do |p|
      @playlists_hash[p.name] = p.id
    end
  end

  def register_playlist
    if params["playlist_id"].present?
      @current_user.playlist_id = params["playlist_id"]
      @current_user.save!
      redirect_to :action => "index"
    end
  end

  private
    def check_current_user
      if @current_user.blank?
        redirect_to "/"
      end
    end

end
