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
  
  def show
    @slot = Slot.find(params[:id])
  end
  
end
