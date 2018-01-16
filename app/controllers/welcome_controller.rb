class WelcomeController < ApplicationController
  def index
    @tracks = Track.where("release_date >= ?", Time.now - 1.weeks).order("RAND()").limit(6)
  end

  def update_playlist
    if @current_user.blank? || @current_user.playlist_id.blank?
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
