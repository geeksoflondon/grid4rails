class Grid

  def initialize
    @timeslots = self.timeslots
    @rooms = self.rooms
  end

  def timeslots
    timeslots = Rails.cache.read('timeslots')
    unless timeslots.nil?
      return timeslots
    else
      timeslots = Timeslot.all
      Rails.cache.write('timeslots', timeslots)
      return timeslots
    end
  end

  def timeslot(timeslot_id)
    timeslot = Rails.cache.read("timeslot_#{timeslot_id}")
    unless timeslot.nil?
      return timeslot
    else
      timeslot = Timeslot.find(timeslot_id)
      Rails.cache.write("timeslot_#{timeslot_id}", timeslot)
      return timeslot
    end
  end

  def rooms
    rooms = Rails.cache.read('rooms')
    unless rooms.nil?
      return rooms
    else
      rooms = Room.all
      Rails.cache.write('rooms', rooms)
      return rooms
    end
  end

  def slot(slot_id)
    slot = Rails.cache.read("slot_#{slot_id}")
    unless slot.nil?
      return slot
    else
      slot = Slot.find(slot_id)
      slot.timeslot
      Rails.cache.write("slot_#{slot_id}", slot)
      return slot
    end
  end

  def talk(talk_id)
    talk = Rails.cache.read("talk_#{talk_id}")
    unless talk.nil?
      return talk
    else
      talk = Talk.find(talk_id)
      Rails.cache.write("talk_#{talk_id}", talk)
      return talk
    end
  end


end
