class GridController < ApplicationController

  def index
    @timeslots = Timeslot.order('start').all
    @rooms = Room.all
  end

end