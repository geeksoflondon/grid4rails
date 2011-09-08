class Talk < ActiveRecord::Base
  belongs_to :slot

  before_save :expire_cache
  after_save :rebuild_cache
  
  validates_presence_of :title, :if => proc{|obj| obj.description.blank? && obj.speaker.blank? }
  validates_presence_of :description, :if => proc{|obj| obj.title.blank? && obj.speaker.blank? }
  validates_presence_of :speaker, :if => proc{|obj| obj.title.blank? && obj.description.blank? }
  

  def self.unscheduled
    Talk.where("slot = ?", false)
  end

	def is_unscheduled
		if (slot_id == nil)
			return true
		end
		return false
	end

  def schedule_in(slot_id = nil)
    unless self.slot_id == nil
      self.slot_id = nil
      self.save
    end
    self.slot_id = slot_id
    self.save
  end

  private

  def expire_cache
    unless self.slot_id.nil?
       Rails.cache.delete("talk_#{self.slot_id}")
    end
  end

  def rebuild_cache
    unless self.slot_id.nil?
      Rails.cache.write("talk_#{self.slot_id}", self)
    end
  end

end
