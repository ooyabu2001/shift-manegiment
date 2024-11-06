Rails.application.routes.draw do

  #devise_for :admins
  devise_for :admins, skip: [:registrations, :password], controllers: {
  sessions: 'admin/sessions'
  }

  namespace :admin do
    root to: "dashboards#index"
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:index, :destroy],as: 'admin_dashboards_users'
    resources :groups, only: [:index, :destroy],as:'admin_dashboards_groups'
  end

scope module: :public do
 devise_for :users, controllers: {
   invitations: 'public/invitations',
   registrations: 'public/registrations'

 }
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
 resources :messages, only: [:create,:destroy] do
  resource :favorite, only: [:create, :destroy]
 end
 resources :tasks, only: [:index,:show,:create]
 get "day_tasks", to: "tasks#day_tasks", as: "day_tasks"

 end
  resources :notifications, only: [:update]
end

