Rails.application.routes.draw do
  
  root 'home#index'
#   get 'home/index'
  
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
    resources :posts, except: [:index]
    resources :profiles, only: [:new, :create, :edit, :update]
    member do
      get :following, :followers, :following_tags
    end
  end
  
  resources :tags, only: [:show]
  
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
  
#   get  '*not_found' => 'application#routing_error'
#   post '*not_found' => 'application#routing_error'
#   match '*not_found' => 'home#index', via: :all
end
