class Timeslot < ActiveRecord::Base
  validates :end, :uniqueness => {:scope => :start}
  
  def self.non_assignables
    Timeslot.where("assign_slots = ?", false)
  end
end
