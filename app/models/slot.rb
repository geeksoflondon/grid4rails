class Slot < ActiveRecord::Base

  belongs_to :room
  belongs_to :timeslot
  belongs_to :talk

  attr_accessible :talk_id 
  attr_accessible :room_id, :timeslot_id, :talk_id, :as => :admin
  
  validates :timeslot_id, :presence => true
  validates :room_id, :presence => true

  after_save :clear_cache
  after_save :notify

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
        slot = Slot.create({:room_id => room.id, :timeslot_id => timeslot.id}, :without_protection => true)
        puts "Slot #{slot.id} created (#{room.name}, #{timeslot.start.to_s})"
      end
    end

  end

  # Empty (but not necessarily available)
  def self.find_empty
    @slots = Array.new()
    Slot.all.each do | slot |
      if (slot.is_empty?)
        @slots << slot
      end
    end
    return @slots
  end
  
  # Empty and in the future (but not necessarily available)
  def self.find_empty_upcoming
    @slots = Array.new()
    
    upcoming_timeslots = Timeslot.upcoming
    empty_slots.find_empty.each do | slot |
      if (upcoming_timeslots.include?(slot.timeslot))
        @slots << slot
      end
    end
    return @slots
    
  end
  
  # Empty and unlocked (but not necessarily in the future)
  def self.find_all_available
    self.find_available(Slot.all)
  end
  
  # Empty and unlocked from set of slots provided (but not necessarily in the future)
  def self.find_available(slots_to_check)      
    
    @slots = Array.new()
    slots_to_check.each do | slot |
      if (!slot.locked && slot.is_empty?)
        @slots << slot
      end
    end
    
    return @slots
  end

  # Available and in the future
  def self.find_all_available_upcoming
    Slot.find_available_upcoming(Slot.all)    
  end
  
  # Available and in the future
  def self.find_available_upcoming(slots_to_check)      
    
    @slots = Array.new()
    slots_to_check.each do | slot |
      if (!slot.locked && slot.is_empty? && slot.timeslot.is_upcoming?)
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
    $redis.keys("views/slot_#{self.id}*").each do |key|
      $redis.del(key)
    end
  end

  def notify
    if (defined?(PUBNUB) && ENV["REALTIME"] == 'ON')
      PUBNUB.publish({
          'channel' => PUBNUB_CHANNEL,
          'message' => self
      })
    end
  end

end
