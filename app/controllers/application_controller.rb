class ApplicationController < ActionController::Base
  
  include Clearance::Authentication
  
  protect_from_forgery
  
  before_filter :enable_cors
  before_filter :talks_taking_place
  before_filter :version

  # Flag for checking whether a timeslot matching now, exists.
  # Equals false if no timeslot matching now exists; otherwise will be true.
  def talks_taking_place
  	@talks_taking_place = Timeslot.on_now.nil? == true ? false : true 
  end

  def version 
    if (cookies[:version] && !cookies[:version].blank?)
    	@version = cookies[:version] unless (cookies[:version] != "low" && cookies[:version] != "med" && cookies[:version] != "high")    	
    end
    @version ||= "low"
    if (cookies[:version] != @version)
    	cookies[:version] = @version
    end
  end
  
  def set_version
    @version = params[:version] unless (params[:version] != "low" && params[:version] != "med" && params[:version] != "high")
    @version ||= "low"
    cookies[:version] = @version
    if (params[:url])
        redirect_to params[:url]	
    else 
    	redirect_to "/"
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
