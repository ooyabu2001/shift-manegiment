Rails.application.routes.draw do

devise_for :users
devise_scope :user do
  post 'users/guest_sign_in', to: 'sessions#guest_sign_in'
end

 root to: "homes#top"
 get "/homes/about", to: "homes#about", as: "about"

 resources :users, only: [:show,:index,:edit]
 resources :group, only: [:index,:show,:create]
 resources :messages, only: [:create,:destroy]
 resources :tasks, only: [:index,:create]


end
