class GridController < ApplicationController

  before_filter :load_grid

  def index
    @page_id = "grid"
    @timeslots = @grid.timeslots
    @rooms = @grid.rooms
    @description = "All talks."
  end

  def now
    @page_id = "now"
    @timeslots = Array.wrap(Timeslot.now)
    @rooms = Array.wrap(Room.all)
    @description = "What's on now."
  end

  def next
    @page_id = "next"
    @timeslots = Array.wrap(Timeslot.next)
    @rooms = Array.wrap(Room.all)
    @description = "What's on next."
  end

  def show
    @page_id = "timeslot"
    @timeslots = Array.wrap(Timeslot.find(params[:id]))
    @rooms = Array.wrap(Room.all)
    @description = "At this time."
  end

  private

  def load_grid
    @grid = Grid.new
  end

end