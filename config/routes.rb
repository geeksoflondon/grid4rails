Griddy::Application.routes.draw do

  get "home/index"

  match "versions/:version", :to => "application#set_version"


  match "talks/:id/schedule/:date", :to => "talks#schedule", :as => :schedule_talk
  match "talks/:id/schedule", :to => "talks#schedule"
  match "talks/:id/move/:date", :to => "talks#move", :as => :move_talk  
  match "talks/:id/move", :to => "talks#move"
  match "talks/assign_slot", :to => "talks#assign_slot"
  match "talks/:id/swap_slot", :to => "talks#swap_slot"
  match "talks/:id/edit", :to => "talks#edit"
  match "talks/:id/unschedule", :to => "talks#unschedule"
  match "talks/unscheduled", :to => "talks#unscheduled"
  resources :talks

  resources :users

  resources :timeslots

  match "rooms/:room", :to => "rooms#show"
  resources :rooms

  resources :slots

  match 'grid/now', :to => "grid#now"
  match 'grid/next', :to => "grid#next"
  match "grid/:date/rooms/:room", :to => "grid#room"
  match "grid/:date", :to => "grid#date"
  match "grid/:date/sessions/:timeslot", :to => "grid#show"
  match "grid", :to => "grid#date"  
  resources :grid


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
  root :to => "grid#now"


  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
