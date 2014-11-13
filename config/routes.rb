Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  root 'questions#index'

  concern :commentable do
    resources :comments
  end

  resources :questions, concerns: :commentable, shallow: true do
    resources :answers, only: [:create, :update, :destroy], concerns: :commentable do
      post 'accept', on: :member
    end
  end
end
