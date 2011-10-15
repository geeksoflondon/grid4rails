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
	
end
