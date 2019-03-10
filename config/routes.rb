Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'feed', to: "pages#feed"
  get 'dashboard', to: "pages#dashboard"
  get 'my_players', to: "pages#my_players"

  resources :players, only: [:index, :show] do
    get 'players/buy'
    get 'players/sell'
    # member do
    #   post ...
    # end
  end

end
