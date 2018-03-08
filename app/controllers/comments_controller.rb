class CommentsController < ApplicationController
  def index
    @comments = Comment.order(updated_at: :desc).paginate(:page => params[:page], :per_page => 20)
    @title = "Recommended -ユーザーのおすすめ-"
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
        redirect_to :back, notice: "おすすめ投稿をしました。"
      else
        redirect_to :back, alert: "おすすめ投稿でエラーが発生しました。"
      end
    else
      redirect_to "/"
    end
  end

end
