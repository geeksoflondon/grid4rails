class ApplicationController < ActionController::Base

  protect_from_forgery

  before_filter :enable_cors
  before_filter :version

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
  
  def reset
  
  	# Delete the version cookies
  	delete_cookie("version")
  	delete_cookie("version_check")
  	
  	# Reset the session
  	reset_session
  	
  	# Redirect to the homepage
  	redirect_to :controller => "grid", :action => "index"
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

	
	# Removes the specified cookie
	def delete_cookie(name)
		cookies[name] = {:value => '', :expires => Time.at(0)}
	end

end
