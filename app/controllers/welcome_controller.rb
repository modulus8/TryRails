class WelcomeController < ApplicationController
  def index
    @tracks = Track.where("release_date >= ?", Time.now - 1.weeks).order(release_date: :desc)
  end
end
