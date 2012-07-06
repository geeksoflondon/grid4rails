class TalkSweeper < ActionController::Caching::Sweeper
  observe Talk # This sweeper is going to keep an eye on the Talk model
  
  # If our sweeper detects that a Talk was created call this
  def after_create(talk)
    expire_cache_for(talk)
  end

  # If our sweeper detects that a Talk was updated call this
  def after_update(talk)
    expire_cache_for(talk)
  end

  # If our sweeper detects that a Talk was deleted call this
  def after_destroy(talk)
    expire_cache_for(talk)
  end

  private

  def expire_cache_for(talk)

    @controller ||= ActionController::Base.new

    if (!talk.slot.nil?)

      expire_fragment("slot_#{talk.slot.id}_index_xl")

      # Each fragment ID is a composite
      # and includes the version code and page_id
      versions = ["s", "m", "l", "xl"]
      page_ids = ["now", "next", "date-grid", "talk-assign", "room", "timeslot", "room-grid", "recent-changes"]

      # Expire cached content in each version
      versions.each do |version|

        # Expire fragments for each relevant page_id
        page_ids.each do |page_id|

          expire_fragment("slot_#{talk.slot.id}_#{page_id}_#{version}")
          expire_fragment("where_when_#{talk.slot.id}_#{page_id}_#{version}")

        end

      end

    end
    
    expire_action(:controller => "talks", :action => "index")
    expire_action(:controller => "talks", :action => "show", :id => talk.id)

  end
  
end