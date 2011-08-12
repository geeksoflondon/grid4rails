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
  
  def next
    Timeslot.where('start > ?', self.start).find(:all, :order => 'start ASC').first
  end
  
  def prev
    Timeslot.where('start < ?', self.start).find(:all, :order => 'start DESC').first
  end

  def self.upcoming
    Timeslot.where('start >= ?', Time.now).find(:all, :order => 'start ASC')
  end

  def self.past
    Timeslot.where('start < ?', Time.now).find(:all, :order => 'start DESC')
  end

  def self.find_empty
    Timeslot.all # Incomplete. Needs to return list of unique timeslots that have at least one empty slot
  end

end
