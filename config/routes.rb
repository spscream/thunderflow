Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  root 'questions#index'

  concern :commentable do
    resources :comments
  end

  resources :questions, concerns: :commentable, shallow: true do
    resources :answers, only: [:index, :create, :update, :destroy], concerns: :commentable do
      post 'accept', on: :member
    end
  end

  namespace :api do
    namespace :v1 do
      resource :profiles do
        get :me, on: :collection
      end

      resources :questions
    end
  end
end
