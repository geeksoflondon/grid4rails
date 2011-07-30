class TimeslotsController < ApplicationController

  def index
    @timeslots = Timeslot.order('start').all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @timeslots }
      format.json  { render :json => @timeslots }
    end
  end

  def show
    @timeslot = Timeslot.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @timeslot }
      format.json  { render :json => @timeslot }
    end
  end

  def new
    @timeslot = Timeslot.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @timeslot }
      format.json  { render :json => @timeslot }
    end
  end

  def edit
    @timeslot = Timeslot.find(params[:id])
  end

  def create
    @timeslot = Timeslot.new(params[:timeslot])

    respond_to do |format|
      if @timeslot.save
        format.html { redirect_to(@timeslot, :notice => 'Timeslot was successfully created.') }
        format.xml  { render :xml => @timeslot, :status => :created, :location => @timeslot }
        format.json  { render :json => @timeslot, :status => :created, :location => @timeslot }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @timeslot.errors, :status => :unprocessable_entity }
        format.json  { render :json => @timeslot.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @timeslot = Timeslot.find(params[:id])

    respond_to do |format|
      if @timeslot.update_attributes(params[:timeslot])
        format.html { redirect_to(@timeslot, :notice => 'Timeslot was successfully updated.') }
        format.xml  { head :ok }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @timeslot.errors, :status => :unprocessable_entity }
        format.json  { head :ok }
      end
    end
  end

  def destroy
    @timeslot = Timeslot.find(params[:id])
    @timeslot.destroy

    respond_to do |format|
      format.html { redirect_to(timeslots_url) }
      format.xml  { head :ok }
      format.json  { head :ok }
    end
  end

end