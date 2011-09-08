class ApplicationController < ActionController::Base
  include Clearance::Authentication
  protect_from_forgery

  before_filter :talks_taking_place
  before_filter :version

  # Flag for checking whether a timeslot matching now, exists.
  # Equals false if no timeslot matching now exists; otherwise will be true.
  def talks_taking_place
  	@talks_taking_place = Timeslot.now.nil? == true ? false : true 
  end

  def version
    @version = cookies[:version]
    @version ||= "low"
  end

end
