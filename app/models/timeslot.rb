class Timeslot < ActiveRecord::Base
  has_many :slots
  validates :end, :uniqueness => {:scope => :start}

  default_scope order('start')

  def self.non_assignables
    Timeslot.where("assign_slots = ?", false)
  end

  def self.now
    Timeslot.where('start <= ? AND end >= ?', Time.now, Time.now).first
  end

  def self.next
    Timeslot.where('start > ?', Time.now).first
  end

end
