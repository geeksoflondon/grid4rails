class ApplicationController < ActionController::Base

  protect_from_forgery

  before_filter :enable_cors
  before_filter :version

  # Valid versions are s, m, and xl (small, medium, large, extra large)
  def version
  	versions = ['s', 'm', 'l', 'xl']
  	if (params[:version_check] == 'false')
  		cookies[:version_check] = false  	
  		params.delete(:version_check)
  	elsif (!cookies[:version] || cookies[:version].blank?)
  	 	cookies[:version_check] = true  	
  	end 
  	if (cookies[:version] && !cookies[:version].blank?)  
    	@version = cookies[:version] unless (!versions.include?(cookies[:version].to_s)) 	
    end
    if (params[:version] && @version != params[:version])
    	@version = params[:version] unless (!versions.include?(cookies[:version].to_s))
    end
    @version ||= "s"
    if (cookies[:version] != @version)
    	cookies[:version] = @version
    end    
    params[:version] = @version
  end   
  
  
  def enable_cors
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Methods"] = "GET"
  end
  
  
  # Matches /reset, a URL used for resetting the 
  # session and cookies associated with this application
  def reset
  
  	# Delete the version cookies
  	cookies.to_hash.each_pair do |k, v|  	
  		delete_cookie(k.to_sym)
	end 
  	  	
  	# Reset the session
  	reset_session
  	
  	# Redirect to the homepage
  	redirect_to :controller => "grid", :action => "index"
  end  


  # View providing helpful information
  def help
  	@page_id = "help"  	  
  end

  # View for gathering feedback
  def feedback
  	redirect_to url_for :controller => "application", :action => "help", :anchor => "feedback", :version => @version
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
