require 'pubnub'

publish_key   = ENV['PUBNUB_PUBLISH_KEY'] || 'demo'
subscribe_key = ENV['PUBNUB_SUBSCRIBE_KEY'] || 'demo'
secret_key    = ENV['PUBNUB_SECRET_KEY'] || ''
ssl_on        = false

if ENV["DISABLE_PUBNUB"] != "true"
  
  puts('Creating new PubNub Client API')

  ## -----------------------------------------
  ## Create Pubnub Client API (INITIALIZATION)
  ## -----------------------------------------
  
  PUBNUB_CHANNEL = 'griddy'
  
  PUBNUB = Pubnub.new(
      publish_key,
      subscribe_key,
      secret_key,
      ssl_on
  )  
  
else
  puts("Pubnub disabled")
end 