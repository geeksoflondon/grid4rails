class SlotsController < ApplicationController
  def index
    respond_to do |format
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
