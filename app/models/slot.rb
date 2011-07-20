class Slot < ActiveRecord::Base
  belongs_to :room, :class_name => "Room", :foreign_key => "room_id"
  belongs_to :timeslot, :class_name => "Timeslot", :foreign_key => "timeslot_id"
  has_one :talk, :class_name => "Talk", :foreign_key => "talk_id"
end
