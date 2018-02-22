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
      redirect_to "/mypage", notice: "プレイリストを登録しました。"
    end
  end

  def create_playlist
    if params[:playlist_name].present?
      spotify_user = RSpotify::User.new(@current_user.spo_hash)
      playlist = spotify_user.create_playlist!(params[:playlist_name].to_s, public: true)
      @current_user.playlist_id = playlist.id
      @current_user.save!
      redirect_to "/mypage", notice: "プレイリストを作成しました。"
    end
  end

  def update_property
    property = @current_user.playlist_properties.first
    property.style = params[:style]
    property.updown = params[:updown]
    if params[:instrumentalness][:is].present? && params[:instrumentalness][:num].present?
      property.instrumentalness = params[:instrumentalness][:num].to_f
    elsif params[:instrumentalness][:is].blank? && params[:instrumentalness][:num].present?
      property.instrumentalness = nil
    end

    if params[:liveness][:is].present? && params[:liveness][:num].present?
      property.liveness = params[:liveness][:num].to_f
    elsif params[:liveness][:is].blank? && params[:liveness][:num].present?
      property.liveness = nil
    end

    if params[:acousticness][:is].present? && params[:acousticness][:num].present?
      property.acousticness = params[:acousticness][:num].to_f
    elsif params[:acousticness][:is].blank? && params[:acousticness][:num].present?
      property.acousticness = nil
    end

    if params[:danceability][:is].present? && params[:danceability][:num].present?
      property.danceability = params[:danceability][:num].to_f
    elsif params[:danceability][:is].blank? && params[:danceability][:num].present?
      property.danceability = nil
    end

    if params[:energy][:is].present? && params[:energy][:num].present?
      property.energy = params[:energy][:num].to_f
    elsif params[:energy][:is].blank? && params[:energy][:num].present?
      property.energy = nil
    end

    if params[:valence][:is].present? && params[:valence][:num].present?
      property.valence = params[:valence][:num].to_f
    elsif params[:valence][:is].blank? && params[:valence][:num].present?
      property.valence = nil
    end

    if property.save
      redirect_to "/mypage", notice: "トラックの条件を更新しました。"
    end

  end

  private
    def check_current_user
      if @current_user.blank?
        redirect_to "/"
      end
    end

end
