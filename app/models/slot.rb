class Slot < ActiveRecord::Base
  belongs_to :room
  belongs_to :timeslot
  has_one :talk

  validates :timeslot_id,
  	:presence => true

  validates :room_id,
  	:presence => true

  def start
    timeslot.start
  end

  def end
    timeslot.end
  end

  def self.generate!

    Slot.delete_all

    Timeslot.all.each do |timeslot|

      Room.all.each do |room|

        Slot.create(:room_id => room.id, :timeslot_id => timeslot.id)

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

  def is_empty?
    if (self.talk_id.nil?)
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


end
