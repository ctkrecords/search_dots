Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # Devise routes por admins
  devise_for :admins, 
    :controllers => { :sessions => "users/sessions", :passwords=>"users/passwords"}, 
    :path => "", :path_names => { :sign_in => 'admin', :sign_out => 'logout'}
    #, :confirmation => 'verification', :unlock => 'unblock', :registration => 'register', :sign_up => 'cmon_let_me_in' }
  #devise_for :admins, path:"" ,path_names: { sign_in: 'admin', sign_out: 'logout'}, controllers: { sessions: "users/sessions", passwords: "users/passwords"}
  devise_for :talent_hunters, 
    :controllers => { :sessions => "hunters/sessions", :passwords=>"hunters/passwords"}, 
    :path => "", :path_names => { :sign_in => 'login', :sign_out => 'sign_out'}
    #, :confirmation => 'verification', :unlock => 'unblock', :registration => 'register', :sign_up => 'cmon_let_me_in' }

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
  # routes for super admins 

  # Talent Hunter Routes
  get "/dashboard" => "hunters/home#dashboard", as: :hunter_home
  get "/hunters/dots/assing_dot" => "hunters/dots#assing_dot"
  namespace :hunters, :as=> "hunters" do
    resources :dots, :only=>[:index, :show, :edit] do
      member do
        get :assing_dot
        get :edit_up
      end
    end
  get "my_profile"  => "home#profile"
  get "my_profile/edit"  => "home#edit"
  post "my_profile/save"  => "home#save_profile"
  
  end

  # Country Admin namespaces:
  namespace :modules, :as=> "modules" do
    #resources :dots
    get "/dots" => "dots#index"
    get "/dots/manage" => "dots#view"

    #match '/panel/home' => "panel#home", as: :modules_home
    get '/panel/home' => "panel#home", as: :modules_home
    get '/dots/assing_scored' => "dots#assing_scored"
    
    get "/reports/" => "report#index"
    get "/reports/countries" => "report#countries"
    get "/reports/countries/:id" => "report#countries"
    get "/reports/company" => "report#company"
    get "/reports/show" => "report#show"
    #get "/reports/hunter" => "report#hunter"
    get "/reports/track" => "report#track"
    get "/reports/quarter" => "report#quarter"
    get "/reports/quarter_hunter" => "report#quarter_hunter"
    get "/reports/consolidated" => "report#consolidated"



  end

  #Routes fir company admins
  get "/admin_modules/dots/index"
  get "/admin_modules/panel/home", as: :admin_modules_home
  #get "/admin_modules/panel/settings" =>"admin_modules/panel#settings", :as => "admin_panel_settings"
  #post "/admin_modules/panel/settings" =>"admin_modules/panel#settings", :as => "admin_panel_settings"

  get "/admin_modules/panel/settings", to: "admin_modules/panel#settings", as: "admin_panel_settings"
  post "/admin_modules/panel/settings", to: "admin_modules/panel#settings", as: "admin_panel_settings2"

  get "/admin_modules/panel/work_calendar" =>"admin_modules/panel#work_calendar"
  post "/admin_modules/panel/new_calendar" =>"admin_modules/panel#new_calendar"
  get "/admin_modules/panel/delete_calendar/:id" =>"admin_modules/panel#delete_calendar"
  get "/admin_modules/panel/work_timeframes/:id" =>"admin_modules/panel#work_timeframes"
  get "/admin_modules/panel/work_timeframes_set_month/" =>"admin_modules/panel#work_timeframes_set_month"
  get "/admin_modules/panel/disable_timeframe/:id" =>"admin_modules/panel#disable_timeframe"
  get "/admin_modules/panel/delete_timeframe/:id" =>"admin_modules/panel#delete_timeframe"

  get "/admin_modules/dots/index" => "admin_modules/dots#index"
  post "/admin_modules/dots/create" => "admin_modules/dots#create"
  get "/admin_modules/dots/delete/:id" => "admin_modules/dots#delete"
  get "/admin_modules/dots/countries" => "admin_modules/dots#countries"
  post "/admin_modules/dots/assing_dot_to/:id" => "admin_modules/dots#assing_dot_to"
  post "/admin_modules/dots/update_dot/:id" => "admin_modules/dots#update_dot"
  get "/admin_modules/dots/hunters" => "admin_modules/dots#talent_hunters"
  get "/admin_modules/dots/goals" => "admin_modules/dots#assing_goals_for_dots"
  get "/admin_modules/dots/remove_country_dots/:id" => "admin_modules/dots#remove_country_dots"
  get "/admin_modules/dots/assing_goals_for_dots/:id" => "admin_modules/dots#assing_goals_for_dots"
  get "/admin_modules/dots/assing_goals" => "admin_modules/dots#assing_goals"
  
  get "/admin_modules/my_profile" =>"admin_modules/admins#profile"
  #match "/admin_modules/edit_profile/:id" => "admin_modules/admins#edit_profile"
  get "/admin_modules/edit_profile/:id" => "admin_modules/admins#edit_profile"
  #match "/admin_modules/update_profile/:id" => "admin_modules/admins#update_profile"
  get "/admin_modules/update_profile/:id" => "admin_modules/admins#update_profile"
  get "/admin_modules/my_password" => 'admin_modules/admins#my_password'
  #match "/admin_modules/change_password" => 'admin_modules/admins#change_password'
  get "/admin_modules/change_password" => 'admin_modules/admins#change_password'
  get "/admin_modules/admins/password/:id" => "admin_modules/admins#edit_password_admin", as: "change_admin_password"
  post "/admin_modules/admins/password/:id" => "admin_modules/admins#update_password_admin", as: "update_admin_password"
  get "/admin_modules/admins/update"

  #Resources for company admins
  namespace :admin_modules do
    resources :admins
    resources :talent_hunters  do
      get 'change_password', :on => :member
      post 'update_password', :on => :member
    end
  end
  
  #Resources for super admins
  resources :companies
  resources :countries
  
  resources :admins
  resources :talent_hunters

  # routes for super admins 
  get "settings/index"
  get "settings/data"
  
  #match "my_profile" => "admins#profile"
  #match "/admins/edit_profile/:id" => "admins#edit_profile"
  #match "/admins/update_profile/:id" => "admins#update_profile"

  get "my_profile" => "admins#profile"
  get "/admins/edit_profile/:id" => "admins#edit_profile"
  get "/admins/update_profile/:id" => "admins#update_profile"


  #match "/change_password" => 'admins#password'
  #match "/change_password_user" => 'admins#password_user'
  #match "/my_password" => 'admins#my_password'

  get "/change_password" => 'admins#password'
  get "/change_password_user" => 'admins#password_user'
  get "/my_password" => 'admins#my_password'

  get '/panel/home'
  get '/panel/settings'
  get '/panel/reports'

  #match '/companies/countries/:id' => 'companies#countries'
  #match '/companies/assing_country_to/:id' => 'companies#assing_country_to'
  #match '/companies/delete_country_from/:id' => 'companies#delete_country_from'
  #match '/companies/admins/:id' => 'companies#admins'
  #match '/companies/edit_admin/:id' => 'companies#edit_admin'
  #match '/companies/update_admin/:id' => 'companies#update_admin'

  get '/companies/countries/:id' => 'companies#countries'
  get '/companies/assing_country_to/:id' => 'companies#assing_country_to'
  get '/companies/delete_country_from/:id' => 'companies#delete_country_from'
  get '/companies/admins/:id' => 'companies#admins'
  get '/companies/edit_admin/:id' => 'companies#edit_admin'
  get '/companies/update_admin/:id' => 'companies#update_admin'
  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'panel#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
