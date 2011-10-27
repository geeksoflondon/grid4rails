namespace :db do
  
  desc <<-DESC
  	Drop, create, migrate then seed the database with data for BarcampLondon9
  	This file should contain all the record creation needed to seed the database with its default values.
  	Run using the command 'rake db:load_bcl9
  DESC
  
  task :fill_grid => [:environment] do
    
    # Empty caches
    Rake::Task['tmp:cache:clear'].invoke
    Rake::Task['redis:clear_everything'].invoke
    
  	#Firstly lets destroy anything we can find
  	puts "Total Timeslots: " + Timeslot.all.count.to_s
  	puts "Total Rooms: " + Room.all.count.to_s
  	puts "Total Slots: " + Slot.all.count.to_s
  	puts "Total Talks: " + Talk.all.count.to_s
  	
  	empty_slots = Slot.find_empty
  	puts "Total empty slots: " + empty_slots.count.to_s
  	
  	locked_empty_slots = 0
  	empty_slots.each do |slot|
  	 if (slot.locked != true)
      talk = Talk.create(:title => "Writing of my own free will, without a Shaman or a Commander,...", :description => "or some other fusspot standing over me hissing with impatience, driving me on, is something I haven't done for ages.  And the sa", :speaker => "me goes for drawing.  I set about doing both these things now fo")
      talk.slot = slot
      talk.save
     else
       locked_empty_slots = locked_empty_slots + 1	  
  	 end
  	end
  	
  	puts "Total locked empty slots: " + locked_empty_slots.to_s
  	puts "Total Talks: " + Talk.all.count.to_s
  		
  	# Confirm seed completed
  	puts "Population complete."  
    
  end
  
end