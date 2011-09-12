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
        format.html { redirect_to :controller => 'talks', :action => 'schedule', :id => @talk.id }
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
    
    # Need to change so that timeslots can be retrieved from @grid
    if (params[:date])
    	@timeslots = Timeslot.by_date(params[:date])
    else
    	@timeslots = Timeslot.auto_date
    end
    @date = @timeslots.first.start.to_date
    if (params[:date].nil?) 
    	# Why is date appearing in query string rather than url?
    	redirect_to :controller => "talks", :action => "schedule", :date => @date, :id => params[:id] 
    end
 
    @dates = Array.wrap(Timeslot.dates)
    @scroller_date = true
    @rooms = @grid.rooms
    @show_room_col = true
    @empty_slot_index = 0
    @description = "The grid, showing empty slots"
  end

  def assign_slot
    talk = Talk.find(params[:talk][:id])
    slot = Slot.find(params[:talk][:slot_id])
    slot.talk_id = talk.id
    
    # Bug means that notice won't show if defined in redirect_to statement
    # http://www.ruby-forum.com/topic/830332
    if slot.save      
      flash[:notice] = "Talk was updated" 
      redirect_to :controller => "grid", :action => "date", :date => slot.timeslot.start.to_date
    else
      flash[:warning] = "There was an issue scheduling your talk"
      redirect_to :action => 'schedule', :controller => 'talks', :id => talk.id
    end

  end

  private

  def expire_cache
      expire_fragment('the_grid')
  end

end
