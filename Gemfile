source 'https://rubygems.org'

gem 'rails', '3.2.6'


#### Data

# Database
gem 'pg'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'


#### Client-side

group :assets do
	# gem 'sass-rails', "~> 3.1.0"
	# gem 'coffee-rails', "~> 3.1.0"
	# gem 'uglifier'
end

gem 'jquery-rails', "~> 2.0.0"
gem 'compass'
gem 'haml' # for SASS


# Queueing and Caching

gem 'redis'
gem 'resque'
gem 'resque-scheduler'
gem 'redis-store'


##### Exception Capture and logging

gem 'exceptional'
gem 'newrelic_rpm'


##### Realtime foo

gem 'pubnub-ruby'


##### Environment-specific

group :development do 
  gem 'heroku'
end

group :test do 
  gem 'cucumber-rails', '1.2.1', require: false
  gem 'database_cleaner', '0.7.0'
  # gem 'timecop'
end

group :production do
end

group :development, :test do
end
