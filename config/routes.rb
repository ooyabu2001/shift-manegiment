Rails.application.routes.draw do

 resources :tasks, only: [:index]
  devise_for :users
  devise_scope :user do
  post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
end

 root to: "homes#top"

end
