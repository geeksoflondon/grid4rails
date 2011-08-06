class Slot < ActiveRecord::Base
  belongs_to :room
  belongs_to :timeslot
  has_one :talk

  validates_presence_of :timeslot_id

  def start
    timeslot.start
  end

  def end
    timeslot.end
  end

  def self.generate!
    # KP/Leeky - We are refactoring this sorry Tom

    timeslots = Timeslot.order(:start).all
    rooms = Room.all

    Slot.delete_all

    timeslots.each do |timeslot|
      rooms.each do |room|
        new_slot = Slot.create(:room_id => room.id, :timeslot_id => timeslot.id)

        unless timeslot.assign_slots?
          new_talk = Talk.create(:slot_id => new_slot.id, :title => timeslot.name, :locked => true)
          logger.info new_slot.talk.inspect
        end

        new_slot.save
      end
    end

  end

  def slots_by_room
    Slot.find(:all).select {|i| i.room != nil }.group_by {|i| i.room }
  end

  def slots_without_rooms
    Slot.find(:all).select {|i| i.room == nil }
  end

  def slots_which_are_empty
    Slot.find_all_by_talk_id(nil)
  end

end
