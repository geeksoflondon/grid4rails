class Timeslot < ActiveRecord::Base
  has_many :slots
  validates :end, :uniqueness => {:scope => :start}
  
  default_scope order('start')
  
  # Returns all timeslots that have already started (relative to the current date and time)
  scope :past, where('start < ?', Time.now).order("start DESC")
  
  # Returns all timeslots that have yet to start (relative to the current date and time)
  scope :upcoming, where('start >= ?', Time.now).order("start ASC")

  def self.non_assignables
    Timeslot.where("assign_slots = ?", false)
  end

  # Returns the current timeslot (relative to the current date and time)
  def self.now
    Timeslot.past.last
  end

  # Returns the timeslot that will be next (relative to the current date and time)
  def self.next
    Timeslot.upcoming.first
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
  def self.by_date(date)
  	Timeslot.where('date(start) == ?', date).order("start ASC")
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
  
  def contains_empty_slot 
    empty_slots = Slot.find_empty
    slots.each do |slot|
      if (empty_slots.include?(slot)) 
        true
      end
    end
    false
  end 

end
