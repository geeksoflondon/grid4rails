class StatsController < ApplicationController

  def counter
    @talks = Talk.count - Slot.where('locked' => true).count
    @slots_free = Slot.where('talk_id' => nil).count
    render :layout => false, :content_type => 'application/xml'
  end

  def now
    @page_id = "now"
    @timeslot = Timeslot.on_now
    @date = @timeslot.start.to_date unless @timeslot.nil?
    if @date.nil?
      #Nothing on Yet
    else
      #Whats on now
    end
  end

  def next
    @page_id = "next"
    @timeslot = Timeslot.on_next
    @date = @timeslot.start.to_date unless @timeslot.nil?
    if (@date.nil?)
      #Thats all folks
    else
      #Whats coming up
    end
  end

end
