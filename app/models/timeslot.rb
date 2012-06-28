class Timeslot < ActiveRecord::Base

  has_many :slots
  
  attr_accessible :start, :end, :as => :admin

  validates :end, :uniqueness => {:scope => :start}

  default_scope order('start')

  def self.past
    Timeslot.where('start < ?', Time.now.utc).order("start DESC")
  end

  def self.upcoming
    Timeslot.where('start >= ?', Time.now.utc).order("start DESC")
  end

  def self.non_assignables
    Timeslot.where("assign_slots = ?", false)
  end

  # Returns the slot in this timeslot assigned to the room specified
  def slot_by_room(room)
    self.slots.where('room_id = ?', room.id).first unless room.nil?
  end

  # Returns the current timeslot (relative to the current date and time)
  def self.on_now
    Timeslot.past.last
  end

  # Returns the timeslot that will be next (relative to the current date and time)
  def self.on_next
    Timeslot.upcoming.first
  end

  def on_now?
    (self.start <= Time.now && self.end >= Time.now)
  end

  def on_next?
    self == Timeslot.on_next
  end

  # Returns the timeslot that immediately follows the current timeslot
  def next
    Timeslot.where('start > ?', self.start).find(:all, :order => 'start ASC').first
  end

  # Returns the timeslot that immediately precedes the current timeslot
  def prev
    Timeslot.where('start < ?', self.start).find(:all, :order => 'start ASC').last
  end

  # Returns all timeslots that begin today
  def self.today
    Timeslot.by_date(Date.current())
  end

  # Returns all timeslots that begin during the first day of the event
  def self.first_day
    Timeslot.by_date(Timeslot.all.first.start.to_date)
  end

  # Returns all timeslots that begin during date specified
  def self.by_date(date_in)
    # Timeslot.where('date(start) == ?', date).order("start ASC")
    if (date_in.is_a?(Date))
      date = date_in
    else
      date = Date.strptime(date_in, "%Y-%m-%d")
    end
    Timeslot.where("start between ? and ?", date.beginning_of_day().utc, date.end_of_day().utc)
  end

  # Returns all timeslots that begin either on the current date,
  # or, if there are none on that date, the first day of the event
  # unless the event's already complete, in which case, the last
  # day of the event
  def self.auto_date
    @timeslots = Timeslot.today
    if (@timeslots.count < 1)
      if (Timeslot.start_date < Date.current())
        @timeslots = Timeslot.by_date(Timeslot.end_date)
      else
        @timeslots = Timeslot.by_date(Timeslot.start_date)
      end
    end
    return @timeslots
  end

  # Returns all timeslots that begin on a day matching the day name specified
  def self.by_day(name)

    # Timeslot.where("DATE(start) = ?", '2011-09-05').order("start ASC")
    Timeslot.group("date(start)")

    # Timeslot.where("start.strftime('%w') > ?", 1)
    #SELECT * FROM Timeslots WHERE DATE(start) = '2011-09-05'

  end

  # Returns an array of the dates for which there are timeslots
  def self.dates
    dates = Array.new()
    dates << Timeslot.start_date

    Timeslot.all.each do |timeslot|
      if (!dates.include?(timeslot.start.to_date))
        dates << timeslot.start.to_date
      end
    end

    return dates
  end

  # Returns date of first day of event
  def self.start_date
    Timeslot.all.first.start.to_date
  end

  # Returns date of last day of event
  def self.end_date
    Timeslot.all.last.start.to_date
  end
  
  def duration_in_minutes
    ((self.end - self.start).seconds / 60).round
  end

  def contains_empty_slot?
    @empty_slots = Slot.find_empty
    slots.each do | slot |
      if (@empty_slots.include?(slot))
        return true
      end
    end
    return false
  end

  def global_talk
    Talk.find(self.global_talk_id) unless self.global_talk_id.nil?
  end

  def has_global_talk?
    if (!self.global_talk_id.nil?)
      return true
    end
    return false
  end
  
  def slots_for_display(room = nil, empty = false)
  		if (empty == false)
	  		slots = Array.new
	  		if (self.has_global_talk?)
	  			self.slots.each do |slot|
	  					if (slot.talk)
	  							slots << slot
	  					end
	  			end
	  		else
	  			self.slots.each do |slot|
	  					if (slot.room.include_in_grid? && (room.nil? || room == slot.room))
	  							slots << slot
	  					end
	  			end  			
	  		end
  		else
  			if (room.nil?)
  				slots = timeslot.slots
  			else
  				slots = timeslot.slot_by_room(room)
  			end
  		end
  		slots.sort_by{|slot| [slot.room.id, slot.id]}
  end
  
  
	def self.generate!(session_no = 1, num_timeslots = 2, start_time = nil, session_duration = 30.minutes, break_duration = 5.minutes)
		
		if (start_time.nil?)
			raise
		end
		
		end_time = start_time
		
		i = 0	
		while i < num_timeslots
		
		  if (i > 0)
		  	start_time = end_time
		  end
		  end_time = start_time + session_duration
		
		  timeslot = Timeslot.create(:name => "Session #{session_no}", :start => start_time, :end => end_time)
		  puts "Timeslot #{timeslot.id} created (#{timeslot.name}, #{timeslot.start}, #{timeslot.end})"	  	
		
		  i = i+1
		  session_no = session_no+1
		  end_time = end_time + break_duration unless (i == num_timeslots) 
		
		end
	
		return end_time
		
	end

end