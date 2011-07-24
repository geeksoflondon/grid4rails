class SlotsController < ApplicationController
  def index
    @slots = Slot.find(:all,
                       :joins => :timeslot,
                       :order => 'timeslots.start ASC')
    
    respond_to do |format|
      format.html
    end
  end
  
  def regenerate
    Slot.generate!

    respond_to do |format|
      format.html
    end
  end
end
