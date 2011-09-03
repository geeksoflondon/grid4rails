class Room < ActiveRecord::Base

  validates_presence_of :name, :description, :short_code

  validates_uniqueness_of :short_code, :on => :create, :message => "must be unique"
  validates_format_of :short_code, :with => /^[A-Za-z0-9]{1,5}$/, :on => :create, :message => "is not of the correct format. It must be between one and five letters and numbers without spaces or symbols."

  def slots
    Slot.find_all_by_room_id(id)
  end

  def slots_mixed_with_nonassignables
    (slots + Timeslot.non_assignables).sort_by(:start)
  end

end
