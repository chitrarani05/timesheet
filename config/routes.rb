TimesheetManagement::Application.routes.draw do

  authenticated :user do
    root :to => 'home#index', :as => :authenticated_root
  end
   
  devise_for :users, :controllers => {:confirmations => 'confirmations'}, :skip => [:sessions]
  devise_scope :user do 
    get 'login' => 'devise/sessions#new', :as => :new_user_session
    post 'login' => 'devise/sessions#create', :as => :user_session
    delete 'login' => 'devise/sessions#destroy', :as => :destroy_user_session
    get 'forgot-password' => 'devise/passwords#new', :as => :new_user_password
    get 'confirmation-instruction' => 'confirmations#new', :as => :new_user_confirmation
    put "/confirm" => "confirmations#confirm"
  end
  
  devise_scope :user do 
    put "/confirm" => "confirmations#confirm"
  end
  
  resources :employees, except: ["show"]
  resources :clients
  resources :projects, except: ["show"]
  resources :activity_types, except: ["show"]
  resources :tasksheets 
  get "/projects_for_client" => "tasksheets#projects_for_client"
  
  post "tasksheets/create_row" => "tasksheets#create_row", as: "create_row"

  resources :reports 
  get "/project_for_client" => "reports#project_for_client"
  post "reports/submit_for_approval" => "reports#submit_for_approval", as: "submit_for_approval"
  post "reports/all_submit" => "reports#all_submit", as: "all_submit"
  
  resources :check_reports
  get "/project_for_client_admin" => "check_reports#project_for_client_admin"
  post "check_reports/accept_data" => "check_reports#accept_data", as: "accept_data"
  post "check_reports/reject_data" => "check_reports#reject_data", as: "reject_data"
  post "check_reports/reason_for_rejection" => "check_reports#reason_for_rejection", as: "reason_for_rejection"
  post "check_reports/accept_all_data" => "check_reports#accept_all_data", as: "accept_all_data"
  post "check_reports/reject_all_data" => "check_reports#reject_all_data", as: "reject_all_data"
  
  #match '/check_reports/accept_data' => 'check_reports#accept_data', :via => :get
  #get "check_reports/reject_data/:id" => "check_reports#reject_data", as: "reject_data"
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
   root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
