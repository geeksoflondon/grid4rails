class ApplicationController < ActionController::Base
  include Clearance::Authentication
  protect_from_forgery
  
  before_filter :enable_cors
  before_filter :talks_taking_place
  before_filter :which_stylesheet

  def talks_taking_place
    @talks_taking_place = Timeslot.now.nil?
  end

  def which_stylesheet
    @style = cookies[:version]
  end

  def enable_cors
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Methods"] = "GET"
  end
end
