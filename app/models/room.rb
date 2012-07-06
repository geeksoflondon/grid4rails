class Room < ActiveRecord::Base

	has_many :slots

  attr_accessible :name, :description, :short_code, :capacity, :as => :admin
	
	default_scope order('id')

	validates :name,
	:presence => true,
	:uniqueness => { :case_sensitive => false, :message => "must be unique" }

	validates :description,
	:presence => true

	validates :short_code,
	:presence => true,
	:length => { :minimum => 1, :maximum => 5 },
	:uniqueness => { :case_sensitive => false, :message => "must be unique" },
	:format => { :with => /^[A-Za-z0-9]{1,5}$/, :message => "is not of the correct format. It must be between one and five letters and numbers without spaces or symbols." }

	validates :capacity,
	:presence => true,
	:numericality => { :only_integer => true, :greater_than_or_equal_to => 1 }


	## Static Methods ##

	  	
	def self.by_short_code(short_code)
		Room.where("short_code = ?", short_code).first
	end

	def is_empty?(timeslot)
		self.slots.each do |slot|
			if (slot.timeslot.id == timeslot.id)
				return slot.is_empty?
			end
		end
		return false
	end
	
	
  ## Instance Methods ##  
         
   def slots
     Slot.find_all_by_room_id(id)
   end
 
   def slots_mixed_with_nonassignables
     (slots + Timeslot.non_assignables).sort_by(:start)
   end
   
	
	#######
	
  private  
	
end
