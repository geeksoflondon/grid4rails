class TalksController < ApplicationController

  after_filter :expire_cache, :only => ['create', 'update', 'assign_slot']

  def index
    @page_id = "talks"
    @talks = Talk.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @talks }
      format.json  { render :json => @talks }
    end
  end

  def show
    @page_id = "talk"
    @talk = Talk.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @talk }
      format.json  { render :json => @talk }
    end
  end

  def new
    @page_id = "talk-new"
    @talk = Talk.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @talk }
      format.json  { render :json => @talk }
    end
  end

  def create
    @talk = Talk.new(params[:talk])

    respond_to do |format|
      if @talk.save
        format.html { redirect_to(:action => 'schedule', :controller => 'talks', :id => @talk.id) }
        format.xml  { render :xml => @talk, :status => :created, :location => @talk }
        format.json  { render :json => @talk, :status => :created, :location => @talk }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @talk.errors, :status => :unprocessable_entity }
        format.json  { render :json => @talk.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @page_id = "talk-edit"
    @talk = Talk.find(params[:id])
  end

  def update
    @talk = Talk.find(params[:id])

    respond_to do |format|
      if @talk.update_attributes(params[:talk])
        format.html { redirect_to(@talk, :notice => 'Talk was successfully updated.') }
        format.xml  { head :ok }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @talk.errors, :status => :unprocessable_entity }
        format.json  { render :json => @talk.errors, :status => :unprocessable_entity }
      end
    end
  end

  def schedule
    @page_id = "talk-assign"
    @grid = Grid.new
    @unscheduled = Talk.find(params[:id])    
    @timeslots = @grid.timeslots_containing_empty_slot
    @rooms = @grid.rooms
    @show_room_col = true
    @description = "The grid, showing empty slots"
  end

  def assign_slot
    @talk = Talk.find(params[:talk][:id])

    if @talk.schedule_in(params[:talk][:slot_id])
      redirect_to(grid_index_path, :notice => 'Talk was updated.')
    else
      redirect_to(:action => 'schedule', :controller => 'talks', :id => @talk.id, :notice => 'There was an issue scheduling your talk')
    end

  end

  private

  def expire_cache
      expire_fragment('the_grid')
  end

end
