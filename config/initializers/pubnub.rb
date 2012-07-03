require 'pubnub'

publish_key   = ENV['PUBNUB_PUBLISH_KEY'] || 'demo'
subscribe_key = ENV['PUBNUB_SUBSCRIBE_KEY'] || 'demo'
secret_key    = ENV['PUBNUB_SECRET_KEY'] || ''
ssl_on        = false

PUBNUB_CHANNEL = 'griddy'

## -----------------------------------------
## Create Pubnub Client API (INITIALIZATION)
## -----------------------------------------

puts('Creating new PubNub Client API')

PUBNUB = Pubnub.new(
    publish_key,
    subscribe_key,
    secret_key,
    ssl_on
)