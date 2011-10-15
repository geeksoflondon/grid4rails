namespace :redis do

  task :clear_views => [:environment] do
    REDIS.keys('views/*').each do |key| REDIS.del(key) end
  end

  task :clear_everything => [:environment] do
    REDIS.keys.each do |key| REDIS.del(key) end
  end


end