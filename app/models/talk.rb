class Talk < ActiveRecord::Base

  has_one :slot

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

end
