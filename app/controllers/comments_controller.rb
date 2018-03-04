class CommentsController < ApplicationController
  def index
  end


  def create
    if @current_user.present?
      c = Comment.new(
        body: params[:body],
        user_name: @current_user.name,
        user_id: @current_user.id,
        feeling: params[:feeling],
        track_id: params[:id].to_i
      )
      if c.save
        redirect_to "/", notice: "おすすめ投稿をしました。"
      else
        redirect_to "/", alert: "おすすめ投稿でエラーが発生しました。"
      end
    else
      redirect_to "/"
    end
  end

end
