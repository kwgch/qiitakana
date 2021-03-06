Rails.application.routes.draw do

  root 'home#index'

  get 'public', to: 'home#public_feeds', as: :home_public
  get 'mine', to: 'home#mine', as: :home_mine
  get 'stock', to: 'home#stock', as: :home_stock
  get 'drafts', to: 'posts#drafts', as: :drafts
  get 'posted', to: 'posts#posted', as: :posted
  get 'limited', to: 'posts#limited', as: :limited

  resources :tag_follows, only: [:create, :destroy]

  devise_for :users, controllers: { omniauth_callbacks: "auth" }

  devise_scope :user do
    get 'auth/:provider/callback', to: 'auth#create'
    delete 'auth/destroy/:provider', to: 'auth#destroy', as: :destroy_connection
  end

  post 'preview', to: 'posts#preview', as: :preview

  resources :users, only: [:show] do
    get 'stocks'
    get 'private', to: 'users#limited'
    resources :posts, except: [:index]
    resource :profile, except: [:delete]
    resource :relationship, only: [:create, :destroy]
    member do
      get :following, :followers, :following_tags
    end
  end

  resources :tags, only: [:show] do
    resources :tag_follow, only: [:create, :destroy]
  end

  resource :post, only: [] do
    resources :stocks, only: [:create, :destroy]
  end
end
