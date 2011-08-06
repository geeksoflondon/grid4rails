class Timeslot < ActiveRecord::Base
  validates :end, :uniqueness => {:scope => :start}
  default_scope order('start')

  def self.non_assignables
    Timeslot.where("assign_slots = ?", false)
  end
end
