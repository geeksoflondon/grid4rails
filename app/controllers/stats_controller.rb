class StatsController < ActionController::Base
	
	# All talks by attendees (doesn't include talks in locked slots)
  def talks
                
      @talks = Talk.find_attendee_talks.count
      @slots_free = Slot.find_available.count
      
      render :layout => false, :content_type => 'application/xml'
  end

  def time_till
    t = Timeslot.on_next
    minute = (t.start - Time.now)/60
    @minute = minute.round
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
