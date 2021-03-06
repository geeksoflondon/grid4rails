Griddy::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # The production environment is meant for finished, "live" apps.
  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Disable Rails's static asset server (Apache or nginx will already do this)
  config.serve_static_assets = true

  # Compress JavaScripts and CSS
  config.assets.compress = true

  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = true

  # Generate digests for assets URLs
  config.assets.digest = true

  # Defaults to nil and saved in location specified by config.assets.prefix
  # config.assets.manifest = YOUR_PATH

  # Specifies the header that your server uses for sending files
  config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # See everything in the log (default is :info)
  config.log_level = :debug

  # Prepend all log lines with the following tags
  # config.log_tags = [ :subdomain, :uuid ]

  # Use a different logger for distributed setups
  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

  # Use a different cache store in production
  # config.cache_store = :mem_cache_store
  # config.cache_store = :redis_store, ENV["REDISTOGO_URL"]

  # Enable serving of images, stylesheets, and JavaScripts from an asset server
  if ENV["DISABLE_CLOUDFRONT"] != "true"
    puts("Enabling cloudfront")
    config.action_controller.asset_host = "http://d3m5f8nndd1dly.cloudfront.net"
  else
    puts("Cloudfront disabled")
  end	

  # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
  # config.assets.precompile += %w( search.js )
  config.assets.precompile += ['button.css', 'global.css', 'print.css', 'scaffold.css']
  config.assets.precompile += ['screen/extra_large.css', 'screen/large.css', 'screen/medium.css', 'screen/shared.css', 'screen/small.css']
  config.assets.precompile += ['themes/o2/global.css', 'themes/o2/screen/extra_large.css', 'themes/o2/screen/large.css', 'themes/o2/screen/medium.css', 'themes/o2/screen/shared.css', 'themes/o2/screen/small.css']
  config.assets.precompile += ['themes/default/global.css', 'themes/default/screen/large.css', 'themes/default/screen/medium.css', 'themes/default/screen/shared.css', 'themes/default/screen/small.css']
  config.assets.precompile += ['babble.js', 'jquery.min.js', 'pubnub.js', 'xl.js']
	
  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  # config.active_record.auto_explain_threshold_in_seconds = 0.5
  
end
