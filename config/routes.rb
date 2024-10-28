Rails.application.routes.draw do

  devise_for :admins ,as: 'admins_item'
  devise_for :admin, skip: [:registrations, :password], controllers: {
  sessions: 'admin/sessions'
  },as: 'admin_item'

  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:index, :destroy],as: 'admin_dashboards_users'
    resources :groups, only: [:index, :destroy],as:'admin_dashboards_groups'
  end

scope module: :public do
 devise_for :users
 devise_scope :user do
  post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
 end

 root to: "homes#top"
 get "homes/about", to: "homes#about", as: "about"
 get 'mypage', to: 'users#mypage', as: "users_mypage"

 get "search" => "searches#search"
 resources :users

 resources :groups do
  resources :entries, only: [:create, :destroy]  # グループへの参加と離脱
 end
 post 'group_messages', to: "messages#group_create", as: "group_messages"
 resources :messages, only: [:create,:destroy]
 resources :tasks, only: [:index,:show,:create]

 end
end

