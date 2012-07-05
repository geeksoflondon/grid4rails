source 'https://rubygems.org'

gem 'rails', '3.2.6'


#### Data

# Database
gem 'pg'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'


#### Asset-management

group :assets do
	gem 'sass-rails',   '~> 3.2.3'
  	gem 'coffee-rails', '~> 3.2.1'
  	gem 'uglifier', '>= 1.0.3'
end


#### Client-side

gem 'jquery-rails'
gem 'haml' # for SASS


# Queueing and Caching

gem 'redis'
gem 'resque'
gem 'resque-scheduler'
gem 'redis-store', "~> 1.0.0" 


##### Exception Capture and logging

gem 'exceptional'
gem 'newrelic_rpm'


##### Realtime foo

gem 'pubnub-ruby', "0.0.5"
gem 'json'


##### Environment-specific

group :development do 
  gem 'heroku'
end

group :test do 
  gem "factory_girl_rails", ">= 3.0"
  gem "cucumber-rails", ">= 1.2.1", :require => false
  gem "capybara", ">= 1.1.2"
  gem "shoulda"
  gem "database_cleaner"
  gem 'timecop'
end

group :production do
end

group :development, :test do
	gem "rspec-rails", ">= 2.10.1"
	gem "launchy"
end
