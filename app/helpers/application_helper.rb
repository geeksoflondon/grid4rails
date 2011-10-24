module ApplicationHelper
	
	
	def theme
		"bcl9"
	end

	def current_url(new_params)
		url_for params.merge(new_params)
	end

	def url_for(original_params)
		if (!original_params.is_a?(Hash))
			merged_params = original_params
		else
			if (original_params.include?("version"))
				merged_params = original_params
			else
				new_params = {"version" => @version}
				merged_params = original_params.merge(new_params)
			end
		end
		return super(merged_params)
	end

	def day_name(date, format = "%A")
		return date.strftime(format)
	end

	def page_title
		case @current_controller
		when "application"
			case @current_action
			when "help"
				return "Help"
			when "reset"
				return "Reset"
			end
		when "grid"
			case @current_action
			when "date"
				return day_name(@date)
			when "show"
				case @timeslot
				when @timeslot_on_now
					return "On Now"
				when @timeslot_on_next
					return "On Next"
				else
					return @timeslot.name
				end
			end
		when "talks"
			case @current_action
			when "schedule"
				return "Schedule Talk"
			else
				return "Talks"
			end
		when "rooms"
			return @room.name
		else
			return nil
		end
	end

	def element(context)
		case @page_id
		when "room"
			case context
			when "timeslot_heading"
				return "h3"
			end			
		when "talk"
			case context
			when "talk_title"
				return "h1"
			end
		when "talks", "talks-unscheduled"
			case context
			when "talk_title"
				return "h2"
			end
		when "date-grid", "timeslot"
			case context
			when "timeslot_heading"
				return "h2"
			when "where_when"
				return "h3"
			when "talk_title"
				return "h4"
			end
		end
		return "p"
	end

	def slot_index(slots, slot)
		if (slot.is_empty?)
			@empty_slot_index += 1
		end
		return slot_index = slots.index(slot)
	end

	def next_displayed_slot(slots, current, current_index = nil)
		if (current.nil? || slots.nil? || current == slots.last)
			return nil
		end

		if (current_index == nil)
			current_index = slots.index(current)
		end
		next_index = current_index + 1
		next_slot = slots[next_index] unless (next_index > slots.count)
		if (next_slot.nil?)
			return nil
		elsif (next_slot.timeslot.has_global_talk?)
			if (next_slot.is_empty?)
				return next_displayed_slot(slots, next_slot, next_index)
			end
		elsif (!next_slot.room.include_in_grid)
			return next_displayed_slot(slots, next_slot, next_index)
		end
		return next_slot
	end

	def url_for_logo
		path =  "/images/themes/#{theme}/logo"
		if (@version == 's')
			path = path + "_solid_bg"
		end
		path = path + ".png"
	end
	
	def show_when
		case @version
		when "s"
			case @page_id
			when "talks", "talks-unscheduled"
				return true
			end
		when "m"
			case @page_id
			when "timeslot"
				return false
			else
				return true
			end			
		when "l"
			case @page_id
			when "timeslot"
				return false
			else
				return true
			end			
		when "xl"
		end
		return false
	end
	
	def show_where
		case @page_id
		when "room-grid"
			return false
		end
		return true
	end	
	
	def use_shortcode
		case @version
		when "s"
			case @page_id
			when "talks", "unscheduled-talks"
				return true
			end
			return false
		else
			case @show_room_col				
			when false
				return false
			end
		end
		return true
	end

end
