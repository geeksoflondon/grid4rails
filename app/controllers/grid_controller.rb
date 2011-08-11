class GridController < ApplicationController

  def index    
    @timeslots = Timeslot.all
    @rooms = Room.all
    @description = "All talks."
  end
    
  def now
    @timeslots = Array.wrap(Timeslot.now)
    @rooms = Array.wrap(Room.all)
    @description = "What's on now."
  end
  
  def next
    @timeslots = Array.wrap(Timeslot.next)
    @rooms = Array.wrap(Room.all)
    @description = "What's on next."
  end

end