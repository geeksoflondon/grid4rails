class Talk < ActiveRecord::Base
  has_one :slot

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
