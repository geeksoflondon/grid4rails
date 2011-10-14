class StatsController < ApplicationController

  def talks
    @talks = Talk.count - Slot.where('locked' => true).count
    @slots_free = Slot.where('talk_id' => nil).count
    render :layout => false, :content_type => 'application/xml'
  end

end
