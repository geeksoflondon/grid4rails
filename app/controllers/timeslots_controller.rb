class TimeslotsController < ApplicationController

  def index
    @page_id = "timeslots"
    @timeslots = Timeslot.order('start').all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @timeslots }
      format.json  { render :json => @timeslots }
    end
  end

  def show
    @page_id = "timeslot"
    @timeslot = Timeslot.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @timeslot }
      format.json  { render :json => @timeslot }
    end
  end

  def new
    @page_id = "timeslot-new"
    @timeslot = Timeslot.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @timeslot }
      format.json  { render :json => @timeslot }
    end
  end

  def edit
    @page_id = "timeslot-edit"
    @timeslot = Timeslot.find(params[:id])
  end

  def create
    @timeslot = Timeslot.new(params[:timeslot])

    respond_to do |format|
      if @timeslot.save
        format.html { redirect_to(@timeslot, :notice => 'Timeslot was successfully created.', :version => params[:version]) }
        format.xml  { render :xml => @timeslot, :status => :created, :location => @timeslot }
        format.json  { render :json => @timeslot, :status => :created, :location => @timeslot }
      else
        format.html { render :action => "new", :version => params[:version] }
        format.xml  { render :xml => @timeslot.errors, :status => :unprocessable_entity }
        format.json  { render :json => @timeslot.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @timeslot = Timeslot.find(params[:id])

    respond_to do |format|
      if @timeslot.update_attributes(params[:timeslot])
        format.html { redirect_to(@timeslot, :notice => 'Timeslot was successfully updated.', :version => params[:version]) }
        format.xml  { head :ok }
        format.json  { head :ok }
      else
        format.html { render :action => "edit", :version => params[:version] }
        format.xml  { render :xml => @timeslot.errors, :status => :unprocessable_entity }
        format.json  { head :ok }
      end
    end
  end

  def destroy
    @timeslot = Timeslot.find(params[:id])
    @timeslot.destroy

    respond_to do |format|
      format.html { redirect_to(timeslots_url, :version => params[:version]) }
      format.xml  { head :ok }
      format.json  { head :ok }
    end
  end

end