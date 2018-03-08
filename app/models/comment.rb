class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :track

  after_save :cache_sweep


  private
  def cache_sweep
    ActionController::Base.new.expire_fragment("comments_top")
  end

end
