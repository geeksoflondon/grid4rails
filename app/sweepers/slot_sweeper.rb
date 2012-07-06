class SlotSweeper < ActionController::Caching::Sweeper  
  observe Slot # This sweeper is going to keep an eye on the Slot model
  
  # If our sweeper detects that a Slot was created call this
  def after_create(slot)
    expire_cache_for(slot)
  end
 
  # If our sweeper detects that a Slot was updated call this
  def after_update(slot)
    expire_cache_for(slot)
  end
 
  # If our sweeper detects that a Slot was deleted call this
  def after_destroy(slot)
    expire_cache_for(slot)
  end
 
  private
  
  def expire_cache_for(slot)
       
    @controller ||= ActionController::Base.new
        
    expire_fragment("slot_#{slot.id}_index_xl")
    
    # Each fragment ID is a composite
    # and includes the version code and page_id
    versions = ["s", "m", "l", "xl"]       
    page_ids = ["now", "next", "date-grid", "talk-assign", "room", "timeslot", "room-grid", "recent-changes"]
     
    # Expire cached content in each version
    versions.each do |version|

      # Expire fragments for each relevant page_id
      page_ids.each do |page_id|
        
        expire_fragment("slot_#{slot.id}_#{page_id}_#{version}")
        expire_fragment("where_when_#{slot.id}_#{page_id}_#{version}")
          
        # No need to update timeslot fragment as doesn't reference slot data
        
      end        
    
      expire_action("/#{version}/grid/recent")
      
    end        
    
  end
end