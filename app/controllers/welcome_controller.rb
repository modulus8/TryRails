class WelcomeController < ApplicationController
  def index
    @tracks = Track.all.limit(10)
  end
end
