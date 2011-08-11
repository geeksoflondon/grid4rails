class GridController < ApplicationController

  def index
    @timeslots = Timeslot.all
    @rooms = Room.all
  end

  def now
    redirect_to timeslot_now_path
  end
  
  def next
    redirect_to timeslot_next_path
  end

end