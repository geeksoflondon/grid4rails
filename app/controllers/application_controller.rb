class ApplicationController < ActionController::Base

  protect_from_forgery
  
  before_filter :enable_cors
  before_filter :talks_taking_place
  before_filter :version

  # Flag for checking whether a timeslot matching now, exists.
  # Equals false if no timeslot matching now exists; otherwise will be true.
  def talks_taking_place
  	@talks_taking_place = Timeslot.on_now.nil? == true ? false : true 
  end

  # Valid versions are s, m and l (small, medium, large)
  def version
  	if (params[:version_check] == 'false')
  		cookies[:version_check] = false  	
  		params.delete(:version_check)
  	elsif (!cookies[:version] || cookies[:version].blank?)
  	 	cookies[:version_check] = true  	
  	end 
  	if (cookies[:version] && !cookies[:version].blank?)  
    	@version = cookies[:version] unless (cookies[:version] != "s" && cookies[:version] != "m" && cookies[:version] != "l") 	
    end
    if (params[:version] && @version != params[:version])
    	@version = params[:version] unless (params[:version] != "s" && params[:version] != "m" && params[:version] != "l")
    end
    @version ||= "s"
    if (cookies[:version] != @version)
    	cookies[:version] = @version
    end    
    if (!params[:version])
    	params[:version] = @version
    end
  end
  

  def enable_cors
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Methods"] = "GET"
  end
  
  private
  
	before_filter :instantiate_controller_and_action_names
	
	def instantiate_controller_and_action_names
		@current_action = action_name
		@current_controller = controller_name
	end

  
end
