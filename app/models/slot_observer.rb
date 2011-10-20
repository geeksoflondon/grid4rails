class SlotObserver < ActiveRecord::Observer
	
	def after_save(slot)
		clear_cache(slot)
		notify(slot)
	end
	
	private

	def clear_cache(slot)
		REDIS.keys("views/slot_#{slot.id}*").each do |key|
			REDIS.del(key)
		end
	end

	def notify(slot)
    	PUBNUB.publish({
        	'channel' => PUBNUB_CHANNEL,
        	'message' => slot
    	})
  	end
  
end