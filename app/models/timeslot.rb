class Timeslot < ActiveRecord::Base
  has_many :slots
  validates :end, :uniqueness => {:scope => :start}

  default_scope order('start')

  def self.non_assignables
    Timeslot.where("assign_slots = ?", false)
  end

  def self.now
    Timeslot.past.last
  end

  def self.next
    Timeslot.upcoming.first
  end

  def self.upcoming
        Timeslot.where('start >= ?', Time.now)
  end

  def self.past
    Timeslot.where('start < ?', Time.now)
  end

end
