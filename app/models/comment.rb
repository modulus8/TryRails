class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :track

  after_save :cache_sweep


  private
  def cache_sweep
  end

end
