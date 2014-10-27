Rails.application.routes.draw do

  root 'home#index'

  get 'public', to: 'home#public_feeds', as: :home_public
  get 'mine', to: 'home#mine', as: :home_mine

  resources :relationships, only: [:create, :destroy]

  resources :tag_follows, only: [:create, :destroy]

  devise_for :users, controllers: { omniauth_callbacks: "auth" }

  devise_scope :user do
    get 'auth/:provider/callback', to: 'auth#create'
    delete 'auth/destroy/:provider', to: 'auth#destroy', as: :destroy_connection
  end

  get 'users/:id', to: 'users#show', as: :user

  resources :users, only: [] do
    post 'posts/preview', to: 'posts#preview'
    post 'posts/:id/preview', to: 'posts#preview'
    resources :posts, except: [:index]
    resources :profiles, except: [:index, :delete]
    member do
      get :following, :followers, :following_tags
    end
  end

  resources :tags, only: [:show]
end
