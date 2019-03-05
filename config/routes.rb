Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'feed' to: "pages#feed"
  get 'feed' to: "pages#dashboard"
  get 'feed' to: "pages#my_players"


end
