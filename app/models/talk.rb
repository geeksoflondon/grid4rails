class Talk < ActiveRecord::Base

  has_one :slot
  
  validates_presence_of :title, :if => proc{|obj| obj.description.blank? && obj.speaker.blank? }
  validates_presence_of :description, :if => proc{|obj| obj.title.blank? && obj.speaker.blank? }
  validates_presence_of :speaker, :if => proc{|obj| obj.title.blank? && obj.description.blank? }
  
  validates :description, 
  	:length => { :minimum => 0, :maximum => 500 }

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
