namespace :redis do

  task :clear_views => [:environment] do
    $redis.keys('views/*').each do |key| $redis.del(key) end
  end

  task :clear_everything => [:environment] do
    $redis.keys.each do |key| $redis.del(key) end
  end


end