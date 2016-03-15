Rails.application.routes.draw do
  root to: 'application#new'

  devise_for :users, :controllers=> { registrations: 'registrations' }, :skip => [:sessions, :confirmations], :format=> false

  as :user do
    get '/users/confirmation' => 'confirmations#show', :as => :user_confirmation, :format => false
    post '/users/sign_in' => 'sessions#create', :as => :user_session, :format => false
    delete '/users/sign_out' => 'sessions#destroy', :as => :destroy_user_session, :format => false
  end

  resources :users, except: [:create, :delete], format: false

  resources :documents, format: false do
    resources :pages, shallow: true, format: false
    get 'count', to: 'pages#count', format: false
    #get 'pages', to: 'pages#index'
    #post 'pages', to: 'pages#create'
    #get 'pages/:id', to: 'pages#show'
    #put 'pages/:id', to: 'pages#update'
  end

  get '/validations', to: 'validations#index', format: false

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  match '*path' => 'application#new' ,via: :get, constraints: lambda { |request| !request.path.start_with?('/websocket') }

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
end
