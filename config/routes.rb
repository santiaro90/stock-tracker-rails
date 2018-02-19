Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'user/registrations' }

  root 'welcome#index'

  get 'my-portfolio', to: 'users#my_portfolio'
  get 'my-friends', to: 'users#my_friends'
  get 'search-stocks', to: 'stocks#search'

  resources :user_stocks, only: %i[create destroy]
  resources :users, only: [:show]
  resources :friendships
end
