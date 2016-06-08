Rails.application.routes.draw do
  #get 'sessions/new'

  #get 'users/new'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  resources :cities
  
  root 'cities#index'
  #get 'edit' => 'sessions#current_user'
  get 'auth/:provider/callback', to: "sessions#create_face"
  delete 'sign_out', to: "sessions#destroy_face", as: 'sign_out'
  get 'signup' => 'users#new'
  post 'signup' => 'users#create'
  get 'index' => 'cities#index'
  get 'find' => 'cities#show_cities'
  get 'cities/show'
  get 'show' =>  'cities#show'
  get 'compare' => 'cities#compare'
  post 'compare' => 'cities#compare'
  post 'find' => 'cities#show_cities'
  get 'about' => 'static_pages#about'
  get 'contact' => 'static_pages#contact_us'
  get 'references' => 'static_pages#references'
  get "static_pages/download_pdf"
  get "/articles", to: "articles#generate_report", as: :articles
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get 'edit' => 'users#edit'
  post 'edit' => 'users#update' 
  resources :users 

  resources :cities do
    resources :comments
  end


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
