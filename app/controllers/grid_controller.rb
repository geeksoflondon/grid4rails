class GridController < ApplicationController

  before_filter :load_grid

  def now
    @page_id = "now"
    @show_room_col = false
    @timeslot = Timeslot.on_now
    @timeslots = Array.wrap(@timeslot)
	@date = @timeslots.first.start.to_date
    @is_single_timeslot = (@timeslots.count == 1)
    @scroller_timeslot = true
    @empty_slot_index = 0
    @rooms = Array.wrap(Room.all)
    @description = "What's on now."
  end

  def next
    @page_id = "next"
    @show_room_col = false
    @timeslot = Timeslot.on_next
    @timeslots = Array.wrap(@timeslot)
	@date = @timeslots.first.start.to_date
    @is_single_timeslot = (@timeslots.count == 1)
    @scroller_timeslot = true
    @empty_slot_index = 0
    @rooms = Array.wrap(Room.all)
    @description = "What's on next."
  end

  def show
    @page_id = "timeslot"
    @show_room_col = false
    @timeslot = Timeslot.find(params[:timeslot])
    @timeslots = Array.wrap(@timeslot)
    @date = @timeslots.first.start.to_date
    @is_single_timeslot = (@timeslots.count == 1)
    @scroller_timeslot = true
    @empty_slot_index = 0
    @rooms = Array.wrap(Room.all)
    @description = "At this time."
  end

  def date
    @page_id = "date-grid"
    @show_room_col = true
    if (params[:date])
    	@timeslots = Timeslot.by_date(params[:date])
    else
    	@timeslots = Timeslot.auto_date
    end
    @date = @timeslots.first.start.to_date
    if (params[:date].nil?) 
    	redirect_to :controller => "grid", :action => "date", :date => @date
    end
    @dates = Array.wrap(Timeslot.dates)
    @scroller_date = true
    @is_single_timeslot = (@timeslots.count == 1)
    @empty_slot_index = 0
    @rooms = @grid.rooms
    @description = "All talks."
  end

  def day
    @page_id = "day-grid"
    @show_room_col = true
    @timeslots = Timeslot.by_day(params[:date])
    @date = @timeslots.first.start.to_date
    @is_single_timeslot = (@timeslots.count == 1)
    @empty_slot_index = 0
    @rooms = Array.wrap(Room.all)
    @description = "On this day."
  end

  def room
  	@page_id = "room-grid"
  	@show_room_col = false
  	if (params[:date])
    	@timeslots = Timeslot.by_date(params[:date])
    else
    	@timeslots = Timeslot.auto_date    	
    end
    @date = @timeslots.first.start.to_date
    if (params[:date].nil?) 
    	redirect_to :controller => "grid", :action => "room", :id => params[:id], :date => @date
    end
    @dates = Array.wrap(Timeslot.dates)
  	@room = Room.find(params[:room])
  	@scroller_date = true
  	@is_single_timeslot = (@timeslots.count == 1)
  	@empty_slot_index = 0
  	@rooms = Array.wrap(@room)
  	@description = "What's happening in this room."
  end

  private

  def load_grid
    @grid = Grid.new
  end

end
