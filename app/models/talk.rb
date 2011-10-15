class Talk < ActiveRecord::Base

  has_one :slot

  validates :title, :length => { :minimum => 4, :maximum => 64, :allow_blank => true, :message => "needs to be longer than 4 characters and less than 64" }
  validates :speaker, :length => { :minimum => 4, :maximum => 64, :allow_blank => true, :message => "needs to be longer than 4 characters and less than 64" }

  validates_presence_of :title, :if => proc{|obj| obj.description.blank? && obj.speaker.blank? }
  validates_presence_of :description, :if => proc{|obj| obj.title.blank? && obj.speaker.blank? }
  validates_presence_of :speaker, :if => proc{|obj| obj.title.blank? && obj.description.blank? }

  def self.unscheduled
    talks = Talk.select {|talk| talk.is_unscheduled}
    talks.sort_by(&:updated_at).reverse
  end

  def is_unscheduled
    if (slot == nil)
      return true
    end
    return false
  end

end
