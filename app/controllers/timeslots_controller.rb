class TimeslotsController < ApplicationController
  # GET /timeslots
  # GET /timeslots.xml
  def index
    @timeslots = Timeslot.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @timeslots }
    end
  end

  # GET /timeslots/1
  # GET /timeslots/1.xml
  def show
    @timeslot = Timeslot.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @timeslot }
    end
  end

  # GET /timeslots/new
  # GET /timeslots/new.xml
  def new
    @timeslot = Timeslot.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @timeslot }
    end
  end

  # GET /timeslots/1/edit
  def edit
    @timeslot = Timeslot.find(params[:id])
  end

  # POST /timeslots
  # POST /timeslots.xml
  def create
    @timeslot = Timeslot.new(params[:timeslot])

    respond_to do |format|
      if @timeslot.save
        format.html { redirect_to(@timeslot, :notice => 'Timeslot was successfully created.') }
        format.xml  { render :xml => @timeslot, :status => :created, :location => @timeslot }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @timeslot.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /timeslots/1
  # PUT /timeslots/1.xml
  def update
    @timeslot = Timeslot.find(params[:id])

    respond_to do |format|
      if @timeslot.update_attributes(params[:timeslot])
        format.html { redirect_to(@timeslot, :notice => 'Timeslot was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @timeslot.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /timeslots/1
  # DELETE /timeslots/1.xml
  def destroy
    @timeslot = Timeslot.find(params[:id])
    @timeslot.destroy

    respond_to do |format|
      format.html { redirect_to(timeslots_url) }
      format.xml  { head :ok }
    end
  end
end
