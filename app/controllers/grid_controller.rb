class GridController < ApplicationController

  before_filter :load_grid

  def now
    @page_id = "now"
    @show_room_col = false
    @timeslot = Timeslot.on_now
    @timeslots = Array.wrap(@timeslot)
    @is_single_timeslot = (@timeslots.count == 1)
    @rooms = Array.wrap(Room.all)
    @description = "What's on now."
  end

  def next
    @page_id = "next"
    @show_room_col = false
    @timeslot = Timeslot.on_next
    @timeslots = Array.wrap(@timeslot)
    @is_single_timeslot = (@timeslots.count == 1)
    @rooms = Array.wrap(Room.all)
    @description = "What's on next."
  end

  def show   
    @page_id = "timeslot"
    @show_room_col = false
    @timeslot = Timeslot.find(params[:id])
    @timeslots = Array.wrap(@timeslot)
    @is_single_timeslot = (@timeslots.count == 1)
    @rooms = Array.wrap(Room.all)
    @description = "At this time."
  end

  def date  
    @page_id = "date-grid"
    @show_room_col = true
    if (params[:id])     
    	@timeslots = Timeslot.by_date(params[:id])
    else 
    	@timeslots = Timeslot.auto_date
    end
    @date = @timeslots.first.start.to_date
    @dates = Array.wrap(Timeslot.dates)
    @is_single_timeslot = (@timeslots.count == 1)
    @rooms = @grid.rooms
    @description = "All talks."
  end
  
  def day   
    @page_id = "day-grid"
    @show_room_col = true
    @timeslots = Timeslot.by_day(params[:id])
    @is_single_timeslot = (@timeslots.count == 1)
    @rooms = Array.wrap(Room.all)
    @description = "On this day."
  end

  def room
  	@page_id = "room-grid"
  	@show_room_col = false
  	@room = Room.find(params[:id])
  	@timeslots = Timeslot.all
  	@is_single_timeslot = (@timeslots.count == 1)
  	@rooms = Array.wrap(@room)
  	@description = "What's happening in this room."
  end
  
  private

  def load_grid
    @grid = Grid.new
  end

end