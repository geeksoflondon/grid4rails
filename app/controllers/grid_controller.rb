class GridController < ApplicationController

  def index    
    @timeslots = Timeslot.all
    @rooms = Room.all
    @description = "All talks."
  end
    
  def now
    @timeslot = Timeslot.now    
    @timeslots = Array.wrap(@timeslot) 
    @rooms = Array.wrap(Room.all)
    @description = "What's on now."
  end
  
  def next
    @timeslot = Timeslot.next
    @timeslots = Array.wrap(@timeslot)
    @rooms = Array.wrap(Room.all)
    @description = "What's on next."
  end
  
  def show
    @timeslot = Timeslot.find(params[:id])
    @timeslots = Array.wrap(@timeslot)
    @rooms = Array.wrap(Room.all)
    @description = "At this time."
  end

end