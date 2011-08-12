class Talk < ActiveRecord::Base
  belongs_to :slot
  
  def self.unscheduled
    Talk.where("slot = ?", false)
  end
  
end
