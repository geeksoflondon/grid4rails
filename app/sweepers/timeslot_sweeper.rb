class TimeslotSweeper < ActionController::Caching::Sweeper
  observe Timeslot # This sweeper is going to keep an eye on the Timeslot model
 
  # If our sweeper detects that a Timeslot was created call this
  def after_create(timeslot)
    expire_cache_for(timeslot)
  end
 
  # If our sweeper detects that a Timeslot was updated call this
  def after_update(timeslot)
    expire_cache_for(timeslot)
  end
 
  # If our sweeper detects that a Timeslot was deleted call this
  def after_destroy(timeslot)
    expire_cache_for(timeslot)
  end
 
  private
  
  def expire_cache_for(timeslot)
 
    @controller ||= ActionController::Base.new           
      
    # Each fragment ID is a composite
    # and includes the version code and page_id
    versions = ["s", "m", "l", "xl"]       
    page_ids = ["now", "next", "date-grid", "talk-assign", "room", "timeslot", "room-grid", "recent-changes"]
    slots = Slot.by_timeslot(timeslot) 
           
    # Expire cached content in each version
    versions.each do |version|
      
      # Expire fragments for each relevant page_id   
      page_ids.each do |page_id|
        
        expire_fragment("timeslot_#{timeslot.id}_#{page_id}_#{version}")
          
        # Expire fragments for each slot assigned to this timeslot
        slots.each do |slot|
          
          expire_fragment("slot_#{slot.id}_#{page_id}_#{version}")
          expire_fragment("where_when_#{slot.id}_#{page_id}_#{version}")
          
        end    
        
      end        
    
    end     
    
    expire_action(:controller => "grid", :action => "show", :timeslot => timeslot.id)
    
    # No need to update grid#now and grid#next because they both redirect to grid#show        
                 
  end
end