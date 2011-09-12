module SlotsHelper

	# Bit worried about there being no context to this
	# Is called from /shared/grid/grid
	def classnames(slot)
		classes = Array.new 
		if (slot.timeslot == Timeslot.on_now)
			classes << "now"
		end
		if (slot.is_empty?)
			classes << "empty"
		end
		if (!slot.is_empty? && slot.locked) 
			classes << "break"
		end
		return classes
	end
	
end
