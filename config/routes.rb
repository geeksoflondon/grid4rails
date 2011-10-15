Griddy::Application.routes.draw do

  match "reset", :to => "application#reset", :as => :reset
  match "stats/gecko/count", :to => "stats#talks"

  scope "(:version)", :version => /s|m|l/ do  

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
      resources :talks

    match "rooms/:room", :to => "rooms#show"
      resources :rooms, :only => [:index, :show]

    match 'grid/now', :to => "grid#now"
    match 'grid/next', :to => "grid#next"
    match "grid/:date/rooms/:room", :to => "grid#room"
    match "grid/:date", :to => "grid#date"
    match "grid/:date/sessions/:timeslot", :to => "grid#show"
    match "grid", :to => "grid#date"
      resources :grid, :except => [:new, :create, :edit, :update, :destroy]

    match "help", :to => "application#help"
    match "feedback", :to => "application#feedback"

  end

  root :to => "grid#now"

end
