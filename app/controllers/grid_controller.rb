class GridController < ApplicationController


	def index
		if (params[:version] != 'xl')
		redirect_to :controller => "grid", :action => "date", :version => params[:version]
		end
		@page_id = "grid"
		@timeslots = Array.new()
		on_now = @timeslot_on_now
		on_next = @timeslot_on_next
		@timeslots << on_now unless on_now.nil?
		@timeslots << on_next unless on_next.nil?
		if (@timeslots.first.nil?)
		@date = nil
		else
		@date = @timeslots.first.start.to_date
		end
		@is_single_timeslot = (@timeslots.count == 1)
		@scroller_timeslot = false
		@empty_slot_index = 0
		@rooms = Room.all
		@description = "An at-a-glance view of what's on now and next."
	end


	def now
		@page_id = "now"
		@timeslot = @timeslot_on_now
		@date = @timeslot.start.to_date unless @timeslot.nil?
		flash.keep
		if @date.nil?
		flash[:warning] = "There's nothing on right now."
		redirect_to :controller => "grid", :action => "date", :version => params[:version]
		else
		redirect_to :controller => "grid", :action => "show", :date => @date, :timeslot => @timeslot.id, :version => params[:version]
		end
	end


	def next
		@page_id = "next"
		@timeslot = @timeslot_on_next
		@date = @timeslot.start.to_date unless @timeslot.nil?
		flash.keep
		if (@date.nil?)
		flash[:warning] = "That's all folks!"
		redirect_to :controller => "grid", :action => "date", :version => params[:version]
		else
		redirect_to :controller => "grid", :action => "show", :date => @date, :timeslot => @timeslot.id, :version => params[:version]
		end
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
		@rooms = Room.all
		@description = @timeslot.name
	end


	def date
		@page_id = "date-grid"
		@show_room_col = ((@version == 's') ? false : true)

		if (params[:date])
		@timeslots = Timeslot.by_date(params[:date])
		else
		@timeslots = Timeslot.auto_date
		end

		@date = @timeslots.first.start.to_date

		if (params[:date].nil?)
		flash.keep
		redirect_to :controller => "grid", :action => "date", :date => @date, :version => params[:version]
		end

		@dates = Array.wrap(Timeslot.dates)
		@scroller_date = true
		@is_single_timeslot = (@timeslots.count == 1)
		if (@version == 's')
			@slots = Slot.all.sort_by{|slot| [slot.timeslot.start, slot.room.id, slot.id]}
		end
		@empty_slot_index = 0
		@rooms = Room.all.sort_by{|room|[room.id]}
		@description = "All talks."

		#Chuck the response in varnish for 300 (5 min) seconds.
		response.headers['Cache-Control'] = 'public, max-age=300'
	end


	def room
		@page_id = "room-grid"
		flash.keep
		redirect_to :controller => "rooms", :action => "show", :room => params[:room], :version => params[:version]
	end


	# A view displaying recent changes to the grid
	def recent
		@page_id = "recent-changes"
		@talks = Talk.by_updated
	end

end
