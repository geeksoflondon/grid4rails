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

  private

  def load_grid
    @grid = Grid.new
  end

end