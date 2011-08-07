class GridController < ApplicationController

  def index
    @timeslots = Timeslot.all
    @rooms = Room.all
  end

end