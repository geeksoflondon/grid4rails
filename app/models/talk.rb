class Talk < ActiveRecord::Base
  belongs_to :slot
  
  def self.unscheduled
    Talk.where("slot = ?", false)
  end
  
  def schedule_in(slot_id = nil)
    unless self.slot_id == nil
      self.slot_id = nil
      self.save
    end
    
    self.slot_id = slot_id
    self.save
    
  end
  
end
