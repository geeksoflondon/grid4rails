class StatsController < ActionController::Base

  def talks
    @talks = Talk.count - Slot.where('locked' => true).count
    @slots_free = Slot.where('talk_id' => nil).count
    result = {:talks => @talks, :slots_free => @slots_free}
    render :json => result.to_json
  end

  def time_till
    t = Timeslot.on_next
    minute = (t.start - Time.now)/60
    @minute = minute.round
    result = {:minute => @minute}
    render :json => result.to_json
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
