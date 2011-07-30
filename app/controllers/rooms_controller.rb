class RoomsController < ApplicationController

  def index
    @rooms = Room.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rooms }
      format.json  { render :json => @rooms }
    end
  end

  def show
    @room = Room.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @room }
      format.json  { render :json => @room }
    end
  end

  def new
    @room = Room.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @room }
      format.json  { render :json => @room }
    end
  end

  def edit
    @room = Room.find(params[:id])
  end

  def create
    @room = Room.new(params[:room])

    respond_to do |format|
      if @room.save
        format.html { redirect_to(@room, :notice => 'Room was successfully created.') }
        format.xml  { render :xml => @room, :status => :created, :location => @room }
        format.json  { render :json => @room, :status => :created, :location => @room }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @room.errors, :status => :unprocessable_entity }
        format.json  { render :json => @room.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @room = Room.find(params[:id])

    respond_to do |format|
      if @room.update_attributes(params[:room])
        format.html { redirect_to(@room, :notice => 'Room was successfully updated.') }
        format.xml  { head :ok }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @room.errors, :status => :unprocessable_entity }
        format.json  { render :json => @room.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy

    respond_to do |format|
      format.html { redirect_to(rooms_url) }
      format.xml  { head :ok }
      format.json  { head :ok }
    end
  end

end