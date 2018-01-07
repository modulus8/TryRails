class AdminController < ApplicationController
  before_action :check_admin

  def index
    @users = User.all.order(created_at: :desc)
  end

  private
  def check_admin
    unless @current_user.present? && @current_user.role == "admin"
      redirect_to "/"
    end
  end

end
