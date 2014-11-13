Rails.application.routes.draw do
  devise_for :users
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
