Rails.application.routes.draw do

  get 'group/index'
  get 'group/show'
  get 'users/show'
  get 'users/edit'
  get 'users/index'
 resources :tasks, only: [:index,:create]
  devise_for :users
  devise_scope :user do
  post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
end

 root to: "homes#top"

end
