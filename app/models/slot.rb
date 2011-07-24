class Slot < ActiveRecord::Base
  belongs_to :room
  belongs_to :timeslot
  has_one :talk

  validates_presence_of :timeslot_id

  def self.generate!
    # I would like to point out for posterity that the code below
    # is slow and... I don't care. The value of (rooms.count *
    # slots.count) shouldn't ever be more than a couple of hundred
    # so... who cares about performance? I don't.
    #
    # Screw premature optimization.

    timeslots = Timeslot.find(:all)
    rooms = Room.find(:all)
    slots = Slot.find(:all)

    timeslots.each {|ts|
      if ts.assign_slots? == true
        rooms.each {|rm|
          filtered_selection = slots.select {|sl| sl.room_id == rm.id && sl.timeslot_id == ts.id }
          if filtered_selection.size == 0
            new_slot = Slot.new(:room_id => rm.id, :timeslot_id => ts.id)
            new_slot.save
          end
        }
      end
    }
  end

  def slots_by_room
    Slot.find(:all).select {|i| i.room != nil }.group_by {|i| i.room }
  end

  def slots_without_rooms
    Slot.find(:all).select {|i| i.room == nil }
  end

end
