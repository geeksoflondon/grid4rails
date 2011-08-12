class TalksController < ApplicationController

  def index
    @talks = Talk.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @talks }
      format.json  { render :json => @talks }
    end
  end

  def show
    @talk = Talk.find(params[:id])
    @slots = Slot.find_empty
    @timeslots = Timeslot.find_empty

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @talk }
      format.json  { render :json => @talk }
    end
  end

  def new
    @talk = Talk.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @talk }
      format.json  { render :json => @talk }
    end
  end

  def edit
    @talk = Talk.find(params[:id])
    @slots = Slot.find_empty
  end

  def create
    @talk = Talk.new(params[:talk])

    respond_to do |format|
      if @talk.save
        format.html { redirect_to(@talk, :notice => 'Talk was successfully created.') }
        format.xml  { render :xml => @talk, :status => :created, :location => @talk }
        format.json  { render :json => @talk, :status => :created, :location => @talk }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @talk.errors, :status => :unprocessable_entity }
        format.json  { render :json => @talk.errors, :status => :unprocessable_entity }
      end
    end
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

  def destroy
    @talk = Talk.find(params[:id])
    @talk.destroy

    respond_to do |format|
      format.html { redirect_to(talks_url) }
      format.xml  { head :ok }
      format.json  { head :ok }
    end
  end
  
  def schedule
    @talks = Talk.find(params[:id])
    @slots = Slot.find_empty
    @timeslots = Timeslot.find_empty
  end

end
