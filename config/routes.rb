Rails.application.routes.draw do
  get 'players/index'
  get 'players/show'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'feed', to: "pages#feed"
  get 'dashboard', to: "pages#dashboard"
  get 'my_players', to: "pages#my_players"

  get '/feed' => 'pages#feed', as: :user_root # creates user_root_path

  resources :players, only: [:index, :show] do
    # member do
    #   post ...
    # end
  end

end
