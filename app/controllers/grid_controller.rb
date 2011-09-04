class GridController < ApplicationController

  def index    
    @page_id = "grid"
    @timeslots = Timeslot.all
    @rooms = Room.all
    @description = "All talks."
  end
    
  def now
    @page_id = "now"
    @timeslot = Timeslot.now    
    @timeslots = Array.wrap(@timeslot) 
    @rooms = Array.wrap(Room.all)
    @description = "What's on now."
  end
  
  def next
    @page_id = "next"
    @timeslot = Timeslot.next
    @timeslots = Array.wrap(@timeslot)
    @rooms = Array.wrap(Room.all)
    @description = "What's on next."
  end
  
  def show
    @page_id = "timeslot"
    @timeslot = Timeslot.find(params[:id])
    @timeslots = Array.wrap(@timeslot)
    @rooms = Array.wrap(Room.all)
    @description = "At this time."
  end

  def room
  	@page_id = "room-grid"
  	@room = Room.find(params[:id])
  	@timeslots = Timeslot.all
  	@rooms = Array.wrap(@room)
  	@description = "What's happening in this room."
  end


end