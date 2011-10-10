class Talk < ActiveRecord::Base

  has_one :slot
  
  before_save :expire_cache
  after_save :rebuild_cache


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
