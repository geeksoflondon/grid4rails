class RoomSweeper < ActionController::Caching::Sweeper
  observe Room # This sweeper is going to keep an eye on the Room model
  
  # If our sweeper detects that a Room was created call this
  def after_create(room)
    expire_cache_for(room)
  end
 
  # If our sweeper detects that a Room was updated call this
  def after_update(room)
    expire_cache_for(room)
  end
 
  # If our sweeper detects that a Room was deleted call this
  def after_destroy(room)
    expire_cache_for(room)
  end
 
  private
  
  def expire_cache_for(room)
       
    @controller ||= ActionController::Base.new
    
    # Each fragment ID is a composite
    # and includes the version code and page_id
    versions = ["s", "m", "l", "xl"]       
    page_ids = ["now", "next", "date-grid", "talk-assign", "room", "timeroom", "room-grid", "recent-changes"]
    slots = room.slots 
      
    # Expire cached content in each version
    versions.each do |version|

      # Expire fragments for each relevant page_id
      page_ids.each do |page_id|
        
        # Expire fragments for each slot assigned to this room
        slots.each do |slot|
          
          expire_fragment("slot_#{slot.id}_#{page_id}_#{version}")
          expire_fragment("where_when_#{slot.id}_#{page_id}_#{version}")
          
        end                
          
      end   
    
    end
   
    expire_action(:controller => "rooms", :action => "index")
    expire_action(:controller => "rooms", :action => "show", :room => room.short_code)
     
  end
end