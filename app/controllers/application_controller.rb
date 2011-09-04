class ApplicationController < ActionController::Base
  include Clearance::Authentication
  protect_from_forgery
  
  before_filter :talks_taking_place
  before_filter :which_stylesheet

  def talks_taking_place
    @talks_taking_place = Timeslot.now.nil?
  end

  def which_stylesheet
    @style = cookies[:version]
  end

end
