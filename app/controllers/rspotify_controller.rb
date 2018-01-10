class RspotifyController < ApplicationController

  def log_in
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    spo_hash = spotify_user.to_hash
    p "login#################################"
    p spo_hash
    p "#################################"
    user = User.find_or_create_from_auth(spo_hash)
    # ユーザーIDをセッションに保存する
    session[:user_id] = user.id
    redirect_to "/"
  end

  def log_out
    # ユーザーIDをセッションに削除
    session[:user_id] = nil
    redirect_to "/"
  end

  def save_tracks
    if @current_user.present?
      ids = []
      ids << params[:id].to_s
      tracks = RSpotify::Base.find(ids, 'track')
      spotify_user = RSpotify::User.new(@current_user.spo_hash)
      spotify_user.save_tracks!(tracks)
      redirect_to "/", notice: "保存しました。"
    else
      redirect_to "/", alert: "ログインしてください。"
    end
  end

end
