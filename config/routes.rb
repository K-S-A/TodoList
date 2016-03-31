Rails.application.routes.draw do
  devise_for :users

  root 'application#main'

  resources :projects, shallow: true, except: [:edit, :new], id: /\d+/ do
    resources :tasks, only: [:create, :update, :destroy] do
      resources :comments, only: [:create, :update, :destroy]
    end
  end
end
