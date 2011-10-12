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
  		redirect_to :controller => "rooms", :version => params[:version] and return
  	end
  	
  	@timeslots = Array.new()
  	@timeslots << Timeslot.on_now
  	@timeslots << Timeslot.on_next
  	@date = @timeslots.first.start.to_date unless @timeslots.first.nil?
  	@rooms = Array.wrap(@room)
  	@empty_slot_index = 0

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @room }
      format.json  { render :json => @room }
    end
  end

  def new
    @page_id = "room-new"
    @room = Room.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @room }
      format.json  { render :json => @room }
    end
  end

  def edit
    @page_id = "room-edit"
    @room = Room.find(params[:id])
  end

  def create
    @room = Room.new(params[:room])

    respond_to do |format|
      if @room.save
        format.html { redirect_to(@room, :notice => 'Room was successfully created.', :version => params[:version]) }
        format.xml  { render :xml => @room, :status => :created, :location => @room }
        format.json  { render :json => @room, :status => :created, :location => @room }
      else
        format.html { render :action => "new", :version => params[:version] }
        format.xml  { render :xml => @room.errors, :status => :unprocessable_entity }
        format.json  { render :json => @room.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @room = Room.find(params[:id])

    respond_to do |format|
      if @room.update_attributes(params[:room])
        format.html { redirect_to(@room, :notice => 'Room was successfully updated.', :version => params[:version]) }
        format.xml  { head :ok }
        format.json  { head :ok }
      else
        format.html { render :action => "edit", :version => params[:version] }
        format.xml  { render :xml => @room.errors, :status => :unprocessable_entity }
        format.json  { render :json => @room.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy

    respond_to do |format|
      format.html { redirect_to(rooms_url, :version => params[:version]) }
      format.xml  { head :ok }
      format.json  { head :ok }
    end
  end

end