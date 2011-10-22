class SlotObserver < ActiveRecord::Observer
	
	def after_save(slot)
		notify(slot)
	end

	private

	def notify(slot)
		if (defined?(PUBNUB))
			PUBNUB.publish({
					'channel' => PUBNUB_CHANNEL,
					'message' => slot
			})
		end		
	end

end