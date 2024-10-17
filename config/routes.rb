Rails.application.routes.draw do

devise_for :users
devise_scope :user do
  post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
end

 root to: "homes#top"
 get "homes/about", to: "homes#about", as: "about"
 get 'mypage', to: 'users#mypage', as: "users_mypage"
 
 get "search" => "searches#search"
 resources :users, only: [:show,:index,:edit]
 resources :groups, only: [:index,:show,:create]
 post 'group_messages', to: "messages#group_create", as: "group_messages"
 resources :entries, only: [:create, :destroy]
 resources :messages, only: [:create,:destroy]
 resources :tasks, only: [:index,:create]


end
