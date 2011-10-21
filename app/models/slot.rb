class Slot < ActiveRecord::Base

  belongs_to :room
  belongs_to :timeslot
  belongs_to :talk

  validates :timeslot_id, :presence => true
  validates :room_id, :presence => true
  
  after_save :clear_cache

  def start
    timeslot.start
  end

  def end
    timeslot.end
  end

  def self.generate!
    Slot.delete_all

    Room.all.each do |room|
      Timeslot.all.each do |timeslot|
        slot = Slot.create(:room_id => room.id, :timeslot_id => timeslot.id)
      end
    end

  end

  def self.find_empty
	  @slots = Array.new()
	  Slot.all.each do | slot |
	    if (slot.is_empty?)
	      @slots << slot
	    end
	  end
      return @slots
  end
  
  def self.find_occupied
  	Slot.select {|slot| !slot.is_empty?}
  end

  def is_empty?
    if (self.talk.nil?)
      return true
    else
      return false
    end
  end

  def self.by_timeslot(timeslot)
    Slot.joins(:timeslot).where('timeslots.id = ?', timeslot)
  end

  def self.on_now
    Timeslot.on_now.slots
  end

  def self.on_next
    Timeslot.on_next.slots
  end

  private
  
  def clear_cache
  	REDIS.keys("views/slot_#{self.id}*").each do |key|
  		REDIS.del(key)
	end
end
  
end
