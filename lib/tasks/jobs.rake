namespace :jobs do

  task :work => [:environment] do
    #example
    #Rake::Task['db:drop'].invoke

    dummy_counter = 1
    while dummy_counter < 100
      clear_caches
      sleep(60)
    end

  end

  #Scheduled clearing down of caches
  def clear_caches
    timeslot_now = Timeslot.on_now.id
    prev_timeslot_now = REDIS.get("current_timeslot").to_i

    if timeslot_now != prev_timeslot_now
      #clear the timeslot caches and move the current timeslot
      invalidate_cache("views/timeslot_#{timeslot_now}*")
      invalidate_cache("views/timeslot_#{prev_timeslot_now}*")
      REDIS.set("current_timeslot", timeslot_now)

      #clear the slot caches for the timeslots
      Timeslot.on_now.prev.slots.each do |slot| invalidate_cache("views/slot_#{slot.id}*") end
      Timeslot.on_now.slots.each do |slot| invalidate_cache("views/slot_#{slot.id}*") end
      puts "Cleared Timeslot Related Caches"
    end

  end

  private

  def invalidate_cache(cache_key)
    REDIS.keys(cache_key).each do |key|
      REDIS.del(key)
    end
  end

end