Rails.application.routes.draw do

  delete 'sessions' => 'sessions#destroy'
  #show 'admin/chart' => 'admin_chart'

  #get 'admin/pickcharts/:id' => 'admin#pickchart'

  root 'home#index' #get'/' => 'home#index'

  namespace :admin do
    resource :charts #, defaults: {format: 'js'}
    resources :password, only: [:index, :show, :update]
    #match '/password', :to => 'password#updating_password', :via => :patch
    patch '/password', :to => 'password#updating_password'
    #match '/wins', :to => 'wins#update_wins_and_standings', :via => :update
    resources :standing, only: [:index, :show, :create, :update, :new]
        #resource :archive, only: [:index]
    #match '/archive', :to => 'archive#index', :via => [:get]
    resources :wins, only: [:index, :show]
    match '/wins', :to => 'wins#update_wins_and_standings', :via => :patch
  end
  #below example of route
  #patch "admin/usersupdate" => "admin#usersupdate", :as => "admin/usersupdate"
  #get 'admin/standing', :to => 'admin/#standing'
  #get 'admin/wins', :to => 'admin/#wins'

  namespace :users do
    resources :password, only: [:index, :show, :update]
    resources :standing, only: [:index, :show]
        #resource :archive, only: [:index]
    #match '/archive', :to => 'archive#index', :via => [:get]
  end

  resources :admin
  resources :users
  resources :picks
  resources :sessions

  #resources :chart, path: "/admin/chart"

  # get path line redirects all unrecognized routes back to login page
  get '*path' => redirect('/admin')   unless Rails.env.development?

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
