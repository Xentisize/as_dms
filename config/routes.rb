Rails.application.routes.draw do
  get 'uploads/index'
  get 'school_documents/new_category_field', to: 'school_documents#new_category_field'
  get 'queries/schools/:school', to: 'queries#match_school_name_from_english_or_chinese'
  get 'queries/index'
  get 'queries/search'
  get 'queries/results'
  # get 'print/to_printer'
  post 'print/to_printer'

  mount PdfjsRailsEngine::Engine, at: "pdf"

  # get 'school_documents/new_category_path', to: "school_documents#new_category_field"

  resources :school_documents
  resources :public_exams
  # get 'school_documents/index'

  # get 'school_documents/new'

  # get 'school_documents/create'

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
