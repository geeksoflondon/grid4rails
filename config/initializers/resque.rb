Dir["#{Rails.root}/lib/jobs/*.rb"].each { |file| require file }
Resque.redis = Redis.new(:host => '127.0.0.1', :port => '6379')
