Babylon::Application.routes.draw do

  get "actions/index"

  get "actions/show"

  resources :activities

  get "about", to: 'snippets#show'
  get "imprint", to: 'snippets#show'
  get "help", to: 'snippets#show'
  resources :snippets do
    resources :buckets
  end

  # Settings
  resources :predicates
  resources :item_classifications
  resources :tags
  resources :institutions do
    resources :collections
  end


  # Resource parts
  delete 'destroy_studyassignment' => 'studyassignments#destroy', :as => :destroy_studyassignment
  post 'add_studyassignment' => 'studyassignments#create', :as => :add_studyassignment
  resources :items do
    collection { post :import }
    resources :activities
    resources :issues
    resources :references
    resources :studies
    resources :actions
    resources :buckets
    resources :documents
    resources :sources
  end

  resources :action do
    resources :buckets
  end

  resources :sources do
    resources :buckets
    resources :documents
    resources :issues
    resources :activities
  end

  resources :studies, only: [:index, :show] do
    resources :documents
    resources :references
    resources :issues
    resources :buckets 
  end

  # Research Group Management
  resources :people do
    resources :buckets
    resources :documents
    resources :issues
    resources :activities
    resources :sources
  end

  resources :clusters, :path => 'modules' do
    resources :groups
    resources :projects
    resources :documents
    resources :buckets
    resources :issues
  end

  resources :groups, only: [:index, :show] do
    resources :projects
    resources :documents
    resources :issues
  end

  resources :projects, only: [:index, :show] do
    resources :documents
    resources :todos
    resources :references
    resources :items
    resources :issues
    resources :buckets
    resources :lists
  end

  resources :lists, only: [] do
    resources :studies
  end

  resources :todos, only: [:index, :show, :new] do
    # resources :comments, except: [:index, :show]
    resources :issues
  end


  # Bibliography Management
  resources :serials
  resources :books
  resources :references do
    resources :documents
    resources :buckets
    resources :issues
    resources :activities
    post 'add_to_aspect' => 'project_references#create', :as => :add_to_aspect
    delete 'remove_from_aspect' => 'project_references#destroy', :as => :remove_from_aspect
  end

  # Documents & Assets
  # Standard Document routes
  resources :documents, only: [:index, :show] do
    # resources :comments, except: [:index, :show]
    resources :issues
  end

  # Standard Bucket und Asset routes
  # Assets sind immer die gleichen, können aber in verschiedenen Buckets vorkommen.
  resources :buckets, only: [:index, :show] do
    member do
      put :set_as_cover
      delete :pailful, to: 'pailfuls#destroy'
      post :pailfuls, to: 'pailfuls#create'
    end
    resources :assets, only: [:index, :new, :create]
  end

  resources :assets, except: [:new, :create] do
    resources :issues
    member do
      get :download, to: 'assets#show'
      put :recreate_versions
    end
    collection do
      delete :destroy_multiple
    end
  end

  resources :documents, only: [] do
    member do
      get :download, to: 'documents#download'
    end
  end

  resources :issues, only: [:index] do
    member do
      post :new_comment, to: 'issues#new_comment'
      put :close, to: 'issues#close'
    end
  end

  # Sys
  get 'dashboard', to: 'dashboard#personal'
  get 'explore', to: 'explore#index'
  
  get 'aspect/exit' => 'projects_session#destroy', :as => :exit_aspect
  get 'aspect/change_to' => 'projects_session#create', :as => :change_aspect
  
  # User routes
  devise_for :users

  post "user_connect" => "people#connect_to_user"
  post "user_disconnect" => "people#disconnect_user"

  resources :roles, only: [:index] do
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

  match '(errors)/:status', to: 'errors#show', constraints: {status: /\d{3}/} # via: :all 

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
