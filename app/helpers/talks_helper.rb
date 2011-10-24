module TalksHelper
	
	def url_for_etherpad(talk)
		event_code = event()
		if (!event_code.blank? && !talk.blank?)
			"http://etherpad.wikimedia.org/" + event() + "-" + talk.id.to_s
		end			
	end
		
end
