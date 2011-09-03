class GridController < ApplicationController

  def index
    @page_id = "grid"
    @timeslots = Timeslot.all
    @rooms = Room.all
    @description = "All talks."

    response.headers['Cache-Control'] = 'public, max-age=1' #Storing in varnish for 1 second

  end

  def now
    @page_id = "now"
    @timeslot = Timeslot.now
    @timeslots = Array.wrap(@timeslot)
    @rooms = Array.wrap(Room.all)
    @description = "What's on now."

    response.headers['Cache-Control'] = 'public, max-age=30' #Storing in varnish for 30 seconds

  end

  def next
    @page_id = "next"
    @timeslot = Timeslot.next
    @timeslots = Array.wrap(@timeslot)
    @rooms = Array.wrap(Room.all)
    @description = "What's on next."

    response.headers['Cache-Control'] = 'public, max-age=30' #Storing in varnish for 30 seconds

  end

  def show
    @page_id = "timeslot"
    @timeslot = Timeslot.find(params[:id])
    @timeslots = Array.wrap(@timeslot)
    @rooms = Array.wrap(Room.all)
    @description = "At this time."

    response.headers['Cache-Control'] = 'public, max-age=30' #Storing in varnish for 30 seconds

  end

end