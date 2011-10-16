module SlotsHelper

	# Bit worried about there being no context to this
	# Is called from /shared/grid/grid
	def classnames(slot)
		classes = Array.new 
		if (slot.timeslot == @timeslot_on_now)
			classes << "now"
		end
		if (slot.is_empty?)
			if (slot.locked)
				if (slot.timeslot.global_talk_id.nil?)
					classes << "break" 
				end
			else
				classes << "empty"
			end
		end
		if (slot.locked) 
			classes << "locked"
		end
		return classes
	end
	
end
