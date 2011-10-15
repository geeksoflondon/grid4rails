class TalksController < ApplicationController

  skip_before_filter :verify_authenticity_token

  # A view listing all talks
  def index
    @page_id = "talks"
    @talks = Talk.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @talks }
      format.json  { render :json => @talks }
    end
  end


  # A view of the talk specified
  def show
    @page_id = "talk"
    @talk = Talk.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @talk }
      format.json  { render :json => @talk }
    end
  end


  # A view for entering details about a new talk
  def new
    @page_id = "talk-new"
    @talk = Talk.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @talk }
      format.json  { render :json => @talk }
    end
  end

  # Creates a new talk in the DB using the data specified
  # and then redirects to the "schedule" view
  def create
    @talk = Talk.new(params[:talk])

    respond_to do |format|
      if @talk.save
        session[:talk_id] = @talk.id
        format.html { redirect_to :controller => 'talks', :action => 'schedule', :id => @talk.id, :version => params[:version] }
        format.xml  { render :xml => @talk, :status => :created, :location => @talk }
        format.json  { render :json => @talk, :status => :created, :location => @talk }
      else
        format.html { render :action => "new", :version => params[:version] }
        format.xml  { render :xml => @talk.errors, :status => :unprocessable_entity }
        format.json  { render :json => @talk.errors, :status => :unprocessable_entity }
      end
    end
  end


  # An editable view of the specified talk
  def edit
    @page_id = "talk-edit"
    @talk = Talk.find(params[:id])
  end


  # Updates the details of the specified talk, in the DB
  # and then redirects to the "show" view of that talk
  def update
    @talk = Talk.find(params[:id])

    respond_to do |format|
      if @talk.update_attributes(params[:talk])
        format.html { 			
        	flash[:notice] = "Talk was successfully updated."
        	redirect_to :controller => 'talks', :action => 'show', :version => params[:version] 
        }
        format.xml  { head :ok }
        format.json  { head :ok }
      else
        format.html { render :action => "edit", :version => params[:version] }
        format.xml  { render :xml => @talk.errors, :status => :unprocessable_entity }
        format.json  { render :json => @talk.errors, :status => :unprocessable_entity }
      end
    end
  end


  def remove
    talk = Talk.find(params[:id])

    # Reset the original slot (if there was one)
    if (talk.slot)
      slot = talk.slot
      slot.talk_id = nil

      if slot.save
        flash[:notice] = "Talk was removed from the grid"
        redirect_to :controller => "grid", :action => "date", :date => slot.timeslot.start.to_date, :version => params[:version]
      else
        flash[:warning] = "There was an issue scheduling your talk"
        redirect_to :action => 'schedule', :controller => 'talks', :id => talk.id, :version => params[:version]
      end

    else
      redirect_to :controller => "grid"
    end
  end

  # A view displaying all talks that aren't been assigned to a slot
  def unscheduled
  @page_id = "talks"
    @talks = Talk.unscheduled
  end

  # A view of the grid for the purpose of assigning a talk to a slot
  def schedule
    @page_id = "talk-assign"
    @unscheduled = Talk.find(params[:id])
    session[:talk_id] = @unscheduled.id
	flash.keep

    if (params[:date])
      @timeslots = Timeslot.by_date(params[:date])
    else
      @timeslots = Timeslot.auto_date
    end
    @date = @timeslots.first.start.to_date
    if (params[:date].nil?)
      redirect_to :controller => "talks", :action => "schedule", :date => @date, :id => params[:id], :version => params[:version]
    end

    @dates = Array.wrap(Timeslot.dates)
    @scroller_date = true
    @rooms = Room.all
    @show_room_col = true
    @empty_slot_index = 0
    @description = "The grid, showing empty slots"
  end

  # A view of the grid for the purpose of moving a talk
  # to another slot or off the grid entirely
  def move
    @page_id = "talk-move"
    @unscheduled = Talk.find(params[:id])
    session[:talk_id] = @unscheduled.id

    if (params[:date])
      @timeslots = Timeslot.by_date(params[:date])
    else
      @timeslots = Timeslot.auto_date
    end
    @date = @timeslots.first.start.to_date
    if (params[:date].nil?)
      redirect_to :controller => "talks", :action => "move", :date => @date, :id => params[:id], :version => params[:version]
    end

    @dates = Array.wrap(Timeslot.dates)
    @scroller_date = true
    @rooms = Room.all
    @show_room_col = true
    @empty_slot_index = 0
    @description = "The grid, showing empty slots"
  end


  # Assigns the specified talk to the specified slot
  # and then redirects to a view of the grid on the date that the slot belongs to
  def assign_slot
    talk = Talk.find(session[:talk_id])
    slot = Slot.find(params[:slot])

	# Check whether the slot is locked or already occupied
	if (slot.locked || slot.talk)
		flash[:warning] = "That session is already taken.  Please choose another."
    	redirect_to :action => 'schedule', :controller => 'talks', :id => talk.id, :version => params[:version] and return
	end		

    # Reset the original slot (if there was one)
    if (talk.slot)
      original_slot = Slot.find(talk.slot.id)
      if (!original_slot.nil?)
        original_slot.talk_id = nil
        original_slot.save
      end
    end

    # Create associations between the talk and slot
    slot.talk_id = talk.id

    # Bug means that notice won't show if defined in redirect_to statement
    # http://www.ruby-forum.com/topic/830332
    if slot.save
      flash[:notice] = "Talk was updated"
      session[:talk_id] = nil
      redirect_to :controller => "grid", :action => "date", :date => slot.timeslot.start.to_date, :version => params[:version]
    else
      flash[:warning] = "There was an issue scheduling your talk"
      redirect_to :action => 'schedule', :controller => 'talks', :id => talk.id, :version => params[:version]
    end

  end

  # Swaps the two talks specified
  # and then redirects to a view of the grid on the date that initiating talk is now on
  def swap_slot
  
    # Check that an ID has been provided for both talks
    talk = Talk.find(session[:talk_id])
    if (!session[:talk_id] || !params[:talk_2])
      redirect_to :controller => 'talks', :action => 'move', :id => session[:talk_id], :version => params[:version] and return
    end

    # Check that the talk IDs aren't the same
    if (session[:talk_id] == params[:talk_2])
      redirect_to :controller => 'talks', :action => 'move', :id => session[:talk_id], :version => params[:version] and return
    end

    # Find the specified talks
    talk_1 = Talk.find(session[:talk_id])
    talk_2 = Talk.find(params[:talk_2])

    # Find their existing slots
    slot_1 = Slot.find(talk_1.slot)
    slot_2 = Slot.find(talk_2.slot)

  # Check that both slots have been found
    if (slot_1.nil? || slot_2.nil?)
      redirect_to :controller => 'talks', :action => 'move', :id => session[:talk_id], :version => params[:version] and return
    end

    # Swap the talks
    slot_1.talk_id = talk_2.id
    slot_2.talk_id = talk_1.id

    # Bug means that notice won't show if defined in redirect_to statement
    # http://www.ruby-forum.com/topic/830332
    if (slot_1.save && slot_2.save)
      flash[:notice] = "Talks were successfully swapped"
      redirect_to :controller => "grid", :action => "date", :date => slot_2.timeslot.start.to_date, :version => params[:version]
    else
      flash[:warning] = "There was an issue swapping those talks."
      redirect_to :controller => 'talks', :action => 'move', :id => talk_1.id, :date => slot_1.timeslot.start.to_date, :version => params[:version]
    end

  end

  # De-assigns the specified talk from the specified slot
  # and then redirects to a view of the grid on the date that the slot belongs to
  def unschedule

	  talk = Talk.find(session[:talk_id])
	
	  # Reset the original slot 
	  slot = Slot.find(talk.slot)
	  slot.talk_id = nil

    # Bug means that notice won't show if defined in redirect_to statement
    # http://www.ruby-forum.com/topic/830332
    if slot.save
      flash[:notice] = "Talk was removed from the grid."
      redirect_to :controller => "grid", :action => "date", :date => slot.timeslot.start.to_date, :version => params[:version]
    else
      flash[:warning] = "There was an issue removing your talk from the grid."
      redirect_to :back
    end

  end

end
