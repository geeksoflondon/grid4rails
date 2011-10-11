class RoomsController < ApplicationController

  def index
    @page_id = "rooms"
    @rooms = Room.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rooms }
      format.json  { render :json => @rooms }
    end
  end

  def show
    @page_id = "room"
    @room = Room.by_short_code(params[:room])

    if (@room.nil?)
      flash[:warning] = "Unable to find room requested"
      redirect_to :controller => "rooms" and return
    end

    @timeslots = Array.new()
    @timeslots << Timeslot.on_now
    @timeslots << Timeslot.on_next
    @date = @timeslots.first.start.to_date
    @rooms = Array.wrap(@room)
    @empty_slot_index = 0

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @room }
      format.json  { render :json => @room }
    end
  end

end