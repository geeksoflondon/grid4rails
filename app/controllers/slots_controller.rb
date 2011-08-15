class SlotsController < ApplicationController

  def index
    @slots = Slot.find(:all,
                       :joins => :timeslot,
                       :order => 'timeslots.start ASC')

    respond_to do |format|
      format.html
      format.xml  { render :xml => @slots }
      format.json  { render :json => @slots }
    end
  end

  def allocate
    @slots = Slot.find_empty
  end

  def confirm
    @slot = Slot.find(params[:id])
    @talk = Talk.find(params[:talk])    

    respond_to do |format|
      format.html
      format.xml  { render :xml => @slots }
      format.json  { render :json => @slots }
    end    
  end

  def update
    @slot = Slot.find(params[:id])
    @talk = Talk.find(params[:talk])
    @slot.talk = @talk

    respond_to do |format|
      if @slot.update_attributes(params[:id])
        format.html { redirect_to(@talk, :notice => 'Talk was successfully scheduled.') }
        format.xml  { head :ok }
        format.json  { head :ok }
      else
        format.html { render :action => "schedule", :controller => "talks" }
        format.xml  { render :xml => @talk.errors, :status => :unprocessable_entity }
        format.json  { render :json => @talk.errors, :status => :unprocessable_entity }
      end
    end
  end

  def regenerate
    Slot.generate!

    respond_to do |format|
      format.html
    end
  end

end
