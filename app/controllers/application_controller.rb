class ApplicationController < ActionController::Base

	protect_from_forgery

	before_filter :enable_cors
	before_filter :version
	
	
	# Valid versions are s, m, and xl (small, medium, large, extra large)
	def version
		
		## Array listing the valid version shortcodes
		versions = ['s', 'm', 'l', 'xl']
			
		## Once the user has specified their preference,
		## remove the :version_check parameter.		
		if (params[:version_check] == 'false')
			cookies[:version_check] = false
			params.delete(:version_check)
		end
		
		## If their preference hasn't been stored,
		## ask which version they'd like
		if (!cookies[:version].to_s == 'true' || cookies[:version].blank?)
			version_check = true
			cookies[:version_check] = true
		end
		
		## If the user's preference is stored, 
		## assign the stored value to @version
		if (cookies[:version])
			@version = cookies[:version].to_s unless (!versions.include?(cookies[:version].to_s))
		end
		
		## If the stored value doesn't match the version
		## specified in the current request, 
		## change @version to match that requested
		if (params[:version] && @version != params[:version])
			@version = params[:version] unless (!versions.include?(params[:version]))
		end
		
		## If @version still doesn't have a value,
		## default to small
		## @version ||= "s"
		## default to large
    @version ||= "l"
		
		## If the stored value doesn't match the value of @version,
		## update the stored value to match @version
		if (cookies[:version].to_s != @version)
			cookies[:version] = @version
		end
		
		## Ensure that the current version is
		## available as a parameter
		params[:version] = @version
		
		### Disable initial version check ###  	
    cookies[:version_check] = false
		# if (cookies[:version_check].to_s == 'true' || version_check == true)
		#	  @page_id = 'version-check'
		# 	render 'application/version'			
		# end
		
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
		redirect_to :controller => "grid", :action => "index", :version => 's'
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
		@timeslot_on_now = Timeslot.on_now
		@timeslot_on_next = Timeslot.on_next
	end

	# Removes the specified cookie
	def delete_cookie(name)
		cookies[name] = {:value => '', :expires => Time.at(0)}
	end
	
	def custom_404	
		@page_id = "error-404"				
		render :status => 404
	end

end
