class Talk < ActiveRecord::Base
  has_one :slot
  
  before_save :expire_cache
  after_save :rebuild_cache
  
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

  private

  def expire_cache
    Rails.cache.delete("talk_#{self.id}")
  end

  def rebuild_cache
    Rails.cache.write("talk_#{self.id}", self)
  end

end
