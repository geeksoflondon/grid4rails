if (:environment == 'production')
	publish_key = ENV['PUBNUB_PUBLISH_KEY'];
	subscribe_key = ENV['PUBNUB_SUBSCRIBE_KEY'];
	
	PUBNUB_CHANNEL = 'griddy'.freeze
	
	PUBNUB = Pubnub.new(
	    publish_key,  ## PUBLISH_KEY
	    subscribe_key,  ## SUBSCRIBE_KEY
	    "",      ## SECRET_KEY
	    false    ## SSL_ON?
	)
end