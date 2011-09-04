class Timeslot < ActiveRecord::Base
  has_many :slots
  validates :end, :uniqueness => {:scope => :start}
  
  scope :past, where('start < ?', Time.now).order("start DESC")
  scope :upcoming, where('start >= ?', Time.now).order("start ASC")

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
    Timeslot.where('start < ?', self.start).last
  end

end
