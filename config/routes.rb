Rails.application.routes.draw do

  root 'home#index'

  get 'public', to: 'home#public_feeds', as: :home_public
  get 'mine', to: 'home#mine', as: :home_mine

  resources :tag_follows, only: [:create, :destroy]

  devise_for :users, controllers: { omniauth_callbacks: "auth" }

  devise_scope :user do
    get 'auth/:provider/callback', to: 'auth#create'
    delete 'auth/destroy/:provider', to: 'auth#destroy', as: :destroy_connection
  end

  resources :users, only: [:show] do
    post 'posts/:id/preview', to: 'posts#preview' # => 消したい
    resources :posts, except: [:index] do
      collection do
        post 'preview'
      end
    end
    resource :profile, except: [:delete]
    resource :relationship, only: [:create, :destroy]
    member do
      get :following, :followers, :following_tags
    end
  end

  resources :tags, only: [:show]
end
