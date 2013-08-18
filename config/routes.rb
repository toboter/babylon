Babylon::Application.routes.draw do
  resources :pages do
    resources :buckets
    resources :documents
  end

  # get 'people/about', to: 'explore#index'

  resources :clusters, :path => 'modules' do
    resources :projects
    resources :documents
  end

  resources :areas do
    resources :documents
  end

  resources :groups do
    resources :projects
    resources :documents
  end

  resources :projects, only: [:index, :show] do
    resources :documents
    resources :todolists do
      resources :todos, except: [:show]
    end
  end

  resources :institutions
  resources :serials
  resources :books
  resources :references, :path => 'bibliography'

  resources :people do
    resources :buckets
    resources :documents
  end

  # Standard Document routes
  resources :documents, only: [:index, :show] do
    resources :document_sections
  end

  # Standard Bucket und Asset routes
  # Assets sind immer die gleichen, können aber in verschiedenen Buckets vorkommen.
  resources :buckets, only: [:index] do
    resources :assets, only: [:new, :create, :edit, :update, :destroy]
  end
  resources :assets, only: [:show, :index]

  get 'dashboard', to: 'dashboard#index'
  get 'explore', to: 'explore#index'
  get 'help', to: 'explore#index'

  # User routes
  devise_for :users 

  post "user_connect" => "people#connect_to_user"
  post "user_disconnect" => "people#disconnect_user"

  resources :roles, only: [] do
    collection do
      put :update_multiple
    end
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'explore#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
