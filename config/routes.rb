Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to => "welcome#index"

  devise_for :users, controllers: {
      sessions: 'users/sessions'
  }

  resources :welcome do
    collection do
      get :update_playlist
    end
  end

  resources :tracks, :only => [:index] do
  end

  resources :comments, :only => [:index, :create] do
  end

  resources :rspotify do
    collection do
      get :save_tracks
    end
  end
  get '/auth/spotify/callback', to: 'rspotify#log_in'
  get '/log_out', to: 'rspotify#log_out'


  resources :mypage, :only => [:index] do
    post :register_playlist
    post :create_playlist
    post :update_property
  end


  ##admin###############################################################################
  resources :admin, :only => [:index] do
  end

end
