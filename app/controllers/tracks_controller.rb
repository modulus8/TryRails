class TracksController < ApplicationController
  def index
    if params[:type].present?
      case params[:type]
        when "all_history"
          @tracks = Track.order(played_at: :desc).paginate(:page => params[:page], :per_page => 20)
          @title = "Played Tracks -みんなの再生履歴-"
        when "my_history"
          if @current_user.present?
            spotify_user = RSpotify::User.new(@current_user.spo_hash)
            tracks_hash = create_tracks(spotify_user.recently_played(limit: 20))
            @tracks = Track.where(id: tracks_hash.map(&:id)).paginate(:page => params[:page], :per_page => 20)
            @title = "Tracks You Played -自分の再生履歴-"
          end
      end
    else
      @tracks = Track.where("release_date <= ?", Time.now).order(release_date: :desc).paginate(:page => params[:page], :per_page => 20)
      @title = "Latest Tracks -最新トラック-"
    end
  end

end
