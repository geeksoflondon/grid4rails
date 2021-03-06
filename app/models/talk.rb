class Talk < ActiveRecord::Base

	has_one :slot
	
  attr_accessible :title, :speaker, :description 

	validates :title,
	:length => {
		:minimum => 1,
		:maximum => 64,
		:allow_blank => true,
		:message => "needs to be at least 1 character long and fewer than 64."
	}

	validates :speaker,
	:length => {
		:minimum => 1,
		:maximum => 64,
		:allow_blank => true,
		:message => "needs to be at least 1 character long and fewer than 64."
	}

	validates :description,
	:length => {
		:minimum => 1,
		:maximum => 128,
		:allow_blank => true,
		:message => "needs to be at least 1 character long and fewer than 128."
	}

	validates_presence_of :title, :if => proc{|obj| obj.description.blank? && obj.speaker.blank? }
	validates_presence_of :description, :if => proc{|obj| obj.title.blank? && obj.speaker.blank? }
	validates_presence_of :speaker, :if => proc{|obj| obj.title.blank? && obj.description.blank? }

  
	## Static Methods ##
	  
	  
	# Returns all talks not currently assigned to a slot
	def self.unscheduled
		talks = Talk.select {|talk| talk.is_unscheduled}
		talks.sort_by(&:updated_at).reverse
	end

	
	# Returns the 50 most recently updated talks
	def self.by_updated
		Talk.limit(50).order("updated_at DESC")
	end
	
	
	# Returns all talks that aren't in a locked slot
	def self.find_attendee_talks
	  
    all_talks = Talk.all
    
    @talks = Array.new()
    all_talks.each do | talk |
      slot = talk.slot
      
      puts(slot.locked).to_s
      
      if (!slot.locked)
        @talks << talk
      end
    end
    
    return @talks
	  
	end

	
  ## Instance Methods ##
	
	
	# Returns true if this talk is not assigned to a slot
	def is_unscheduled
		if (self.slot.nil?)
			return true
		end
		return false
	end
	
	
	# Assigns this talk to the slot specified
	# as long as that slot is empty
	def schedule(target_slot)
	  if (target_slot.is_empty?)
      self.slot = target_slot
	  else
	    # do nothing
	  end	  
	end
	
	
  #######
  
  private  

end
