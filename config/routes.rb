Griddy::Application.routes.draw do

  #Mount Resque Web UI
  require "resque/server"
  require "resque_scheduler"
  mount Resque::Server.new, :at => "/resque"

  match "reset", :to => "application#reset", :as => :reset
  match "stats/gecko/count", :to => "stats#talks"
  match "stats/gecko/time", :to => "stats#time_till"

  scope ":version", :version => /s|m|l/ do  

    match "talks/:id/schedule/:date", :to => "talks#schedule", :as => :schedule_talk
    match "talks/:id/schedule", :to => "talks#schedule"
    match "talks/:id/move/:date", :to => "talks#move", :as => :move_talk
    match "talks/:id/move", :to => "talks#move"
    match "talks/:id/edit", :to => "talks#edit"
    match "talks/:id/remove", :to => "talks#remove"
    match "talks/unschedule", :to => "talks#unschedule"
    match "talks/assign_slot", :to => "talks#assign_slot"
    match "talks/swap_slot", :to => "talks#swap_slot"
    match "talks/unscheduled", :to => "talks#unscheduled"
		match "talks/recent", :to => "grid#recent"
      resources :talks

    match "rooms/:room", :to => "rooms#show"
      resources :rooms, :only => [:index, :show]

    match 'grid/now', :to => "grid#now"
    match 'grid/next', :to => "grid#next"
		match "grid/recent", :to => "grid#recent"
    match "grid/:date/rooms/:room", :to => "grid#room"
		match "grid/:date/talks/:talk", :to => "grid#date"
    match "grid/:date/sessions/:timeslot", :to => "grid#show"
    match "grid/:date", :to => "grid#date"
    match "grid", :to => "grid#date"
      resources :grid, :except => [:new, :create, :edit, :update, :destroy]

    match "help", :to => "application#help"
    match "feedback", :to => "application#feedback"

  end

  scope ":version", :version => 'xl' do
  	match 'grid', :to => "grid#index"
  end

  root :to => "grid#now"

  match "*path", :to => "application#custom_404"

end
