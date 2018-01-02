Rails.application.routes.draw do
  resources :tracks
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to => "welcome#index"

  devise_for :users, controllers: {
      sessions: 'users/sessions'
  }

  resources :tracks do
    collection do
      get "index"
    end

    member do
      get "show"
    end
  end



end
