namespace :db do
  
  desc <<-DESC
  	Drop, create, migrate then seed the database with data for BarcampLondon9
  	This file should contain all the record creation needed to seed the database with its default values.
  	Run using the command 'rake db:load_bcl9
  DESC
  
  task :load_now_next_test_event => :environment do  
  
  	# Drop the existing database
    Rake::Task['db:drop'].invoke
    
    # Empty caches
    Rake::Task['tmp:cache:clear'].invoke
    Rake::Task['redis:clear_everything'].invoke
    
    # Create a new instance of the database
    Rake::Task['db:create'].invoke    
    Rake::Task['db:migrate'].invoke
	
  	#Firstly lets destroy anything we can find
  	puts "Deleting existing rooms, timeslots, slots and talks."
  	Room.delete_all
  	Timeslot.delete_all
  	Slot.delete_all
  	Talk.delete_all
  	REDIS.keys('*').each do |key| REDIS.del(key) end
  	
  	puts "Total Timeslots: " + Timeslot.all.count.to_s
  	puts "Total Rooms: " + Room.all.count.to_s
  	puts "Total Slots: " + Slot.all.count.to_s
  	puts "Total Talks: " + Talk.all.count.to_s
  	
  	
  	# Generate Rooms
  	puts "Generating rooms."
  	
  	# Room specs: https://geeksoflondon.basecamphq.com/projects/7251895-barcamp-london-9/posts/52762583/comments
  	# Naming scheme: https://geeksoflondon.basecamphq.com/projects/7251895-barcamp-london-9/cat/73463514/posts
  	
  	room_a = Room.create(
  		:name => 'Everywhere', 
  		:description => 'Any and all rooms (assuming it\'s not out-of-bounds and there\'s no other talk scheduled in it)', 
  		:short_code => 'any', 
  		:capacity => 250, 
  		:include_in_grid => false
  	)
  	room_b = Room.create(
  		:name => 'The Hellmouth', 
  		:description => 'The huge room in the basement; down the stairs and to the left.', 
  		:short_code => 'hel', 
  		:capacity => 250,  
  		:include_in_grid => false
  	)
  	room1 = Room.create(
  		:name => 'Amityville', 
  		:description => 'Basement.', 
  		:short_code => 'amv', 
  		:capacity => 40, 
  		:facilities => 'tbd'
  	)
  	room2 = Room.create(
  		:name => '0001 Cemetery Lane', 
  		:description => 'Basement', 
  		:short_code => 'cem', 
  		:capacity => 40, 
  		:facilities => 'tbd'
  	)
  	room3 = Room.create(
  		:name => 'Little Shop of Horrors', 
  		:description => 'Basement', 
  		:short_code => 'lsh', 
  		:capacity => 40, 
  		:facilities => 'tbd'
  	)
  	room4 = Room.create(
  		:name => 'Lake Placid', 
  		:description => 'First floor.', 
  		:short_code => 'lkp', 
  		:capacity => 40, 
  		:facilities => 'tbd'
  	)
  	room5 = Room.create(
  		:name => 'Island of Lost Souls', 
  		:description => 'First floor.', 
  		:short_code => 'ils', 
  		:capacity => 30, 
  		:facilities => 'tbd'
  	)
  	room6 = Room.create(
  		:name => 'Pan\'s Labrynth', 
  		:description => 'First floor.', 
  		:short_code => 'lab', 
  		:capacity => 30,
  		:facilities => 'tbd'
  	)
  	room7 = Room.create(
  		:name => 'The Black Lagoon', 
  		:description => 'First floor.', 
  		:short_code => 'blk', 
  		:capacity => 30, 
  		:facilities => 'tbd'
  	)
  	room8 = Room.create(
  		:name => 'Burkittsville', 
  		:description => 'Second floor.', 
  		:short_code => 'bkv', 
  		:capacity => 30, 
  		:facilities => 'tbd'
  	)
  	room9 = Room.create(
  		:name => 'Eastwick', 
  		:description => 'Second floor.', 
  		:short_code => 'ewk', 
  		:capacity => 30, 
  		:facilities => 'tbd'
  	)
  	room10 = Room.create(
  		:name => 'Sleepy Hollow', 
  		:description => 'Second floor.', 
  		:short_code => 'slh', 
  		:capacity => 30, 
  		:facilities => 'tbd'
  	)
  	
  	puts "Total Rooms: " + Room.all.count.to_s
  	puts "ID of first Room: " + Room.all.first.id.to_s
  	
  	
  	#Generate Timeslots
  	puts "Generating timeslots."
  	predetermined_talks = Array.new
  	timeslots_to_lock = Array.new
  	
  	
  	## All Timeslots		
  	Timeslot.generate!(1, 10, Time.now.utc, 2.minutes, 1.minute)	
  	
  	
  	## Summary of timeslots created
  	puts "Total Timeslots: " + Timeslot.all.count.to_s
  	puts "ID of first Timeslot: " + Timeslot.all.first.id.to_s unless Timeslot.all.nil?
  	Timeslot.all.each do |timeslot|
  		puts "Timeslot #{timeslot.id}: #{timeslot.start.to_s} - #{timeslot.end.to_s}"
  	end
  	
  	
  	# Generate Slots
  	puts "Generating slots."
  	Slot.generate!
  	
  	puts "Total Slots: " + Slot.all.count.to_s
  	
  	
  	# Generate pre-determined talks
  	puts "Generating pre-determined talks."
  	puts "Total Pre-determined Talk Titles: " + predetermined_talks.count.to_s
  	
  	## Loop through the list of pre-determined talks
  	predetermined_talks.each do |predetermined_talk|
  	
  	  ### Fetch the timeslot
  	  timeslot = predetermined_talk[0]
  	
  	  puts "Timeslot Name: " + timeslot.name   
  	
  	  ### Create a talk with the name specified
  	  talk = Talk.create(:title => timeslot.name, :description => predetermined_talk[2], :speaker => predetermined_talk[3])
  	  
  	  #### Set the talk as the timeslot's global talk
  	  puts "Setting talk " + talk.id.to_s + " as global talk for timeslot " + timeslot.id.to_s
  	  timeslot.global_talk_id = talk.id
  	  timeslot.save
  	  
  	  ### Assign the talk to the room specified, if specified
  	  room = predetermined_talk[1]
  	  if (!room.nil?)
  	  
  	    puts "Room Name: " + room.name  	
  	  	
  	  	#### Fetch the slot this talk is to be scheduled in
  	  	slot = timeslot.slot_by_room(room)
  	  	
  	  	#### Assign the talk to the current slot
  	  	puts "Assigning talk " + talk.id.to_s + " to slot " + slot.id.to_s
  	  	talk.slot = slot
  	  	talk.save
  	  	
  	  	#### Lock the slot
  	    slot.locked = true
  	    slot.save
  	  	
  	  end
  	  
  	end
  	
  	puts "Total Talks: " + Talk.all.count.to_s
  	
  	
  	# Lock timeslots
  	puts "Locking timeslots."
  	puts "Total Timeslots to Lock: " + timeslots_to_lock.count.to_s
  	
  	## Loop through the list of timeslots to lock
  	timeslots_to_lock.each do |timeslot|
  	    	
  	  	### Loop through all the slots in the current timeslot
  	    timeslot.slots.each do |slot|
  	
  			#### Lock the slot
  		    slot.locked = true
  		    slot.save      
  	
  	  	end
  	
  	end
  	
  	
  	# Confirm seed completed
  	puts "Load complete."     
      
  end # task
  
end # namespace