namespace :db do
  
  desc <<-DESC
  	Drop, create, migrate then seed the database with data for BarcampLondon9
  	This file should contain all the record creation needed to seed the database with its default values.
  	Run using the command 'rake db:load_bcl9
  DESC
  
  task :load_bcl9 => [:environment] do
  
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
	
	##Opening Talk
	
	start_time = Time.utc(2011, "oct", 29,9,30,00)
	end_time = start_time + 40.minutes
	timeslot_label = 'Opening Talk'
	timeslot = Timeslot.create(:name => timeslot_label, :start => start_time, :end => end_time)
	predetermined_talks << [timeslot, room_b, "Welcome to BarcampLondon9!", "The Crew", true]
	timeslots_to_lock << timeslot
	
	
	## Grid Population
	
	start_time = end_time
	end_time = start_time + 20.minutes
	timeslot_label = 'Grid Population'
	timeslot = Timeslot.create(:name => timeslot_label, :start => start_time, :end => end_time)
	predetermined_talks << [timeslot, room_a, "Add your talk to the grid", "You", true]
	timeslots_to_lock << timeslot
	
	
	## Saturday Morning
		
	session_no = 1
	num_timeslots = 2
	end_time = Timeslot.generate!(session_no, num_timeslots, end_time)
	session_no = session_no+num_timeslots	
	
	
	## Lunch
	
	start_time = end_time
	end_time = start_time + 1.hour
	timeslot_label = 'Lunch'
	timeslot = Timeslot.create(:name => timeslot_label, :start => start_time, :end => end_time)
	predetermined_talks << [timeslot, room_b, nil, nil, true]
	timeslots_to_lock << timeslot
	
	
	## Saturday Afternoon, Part I
	
	num_timeslots = 2
	end_time = Timeslot.generate!(session_no, num_timeslots, end_time)
	session_no = session_no+num_timeslots	


	## Afternoon Tea
	
	start_time = end_time
	end_time = start_time + 30.minutes
	timeslot_label = 'Afternoon Tea'
	timeslot = Timeslot.create(:name => timeslot_label, :start => start_time, :end => end_time)
	predetermined_talks << [timeslot, room_b, nil, nil, true]
	timeslots_to_lock << timeslot


	## Saturday Afternoon, Part II
	
	num_timeslots = 2
	end_time = Timeslot.generate!(session_no, num_timeslots, end_time)
	session_no = session_no+num_timeslots	

	
	## Dinner
	
	start_time = end_time
	end_time = start_time + 90.minutes
	timeslot_label = 'Dinner'
	timeslot = Timeslot.create(:name => timeslot_label, :start => start_time, :end => end_time)
	predetermined_talks << [timeslot, room_b, nil, nil, true]
	timeslots_to_lock << timeslot
	
	
	## Saturday Evening
	
	num_timeslots = 2
	end_time = Timeslot.generate!(session_no, num_timeslots, end_time)
	session_no = session_no+num_timeslots	
	
	
	## Saturday Night
	
	start_time = end_time
	end_time = Time.utc(2011, "oct", 30,8,00,00)
	timeslot_label = 'Games, etc.'
	timeslot = Timeslot.create(:name => timeslot_label, :start => start_time, :end => end_time)
	predetermined_talks << [timeslot, room_a, nil, nil, true]
	timeslots_to_lock << timeslot
	
	
	## Breakfast
	
	start_time = end_time
	end_time = start_time + 120.minutes
	timeslot_label = 'Breakfast'
	timeslot = Timeslot.create(:name => timeslot_label, :start => start_time, :end => end_time)
	predetermined_talks << [timeslot, room_b, nil, nil, true]
	timeslots_to_lock << timeslot
	
	
	## Sunday Morning, Part I
	
	num_timeslots = 3
	end_time = Timeslot.generate!(session_no, num_timeslots, end_time, 30.minutes)
	session_no = session_no+num_timeslots	


	## Coffee Break
	
	start_time = end_time
	end_time = start_time + 20.minutes
	timeslot_label = 'Coffee Break'
	timeslot = Timeslot.create(:name => timeslot_label, :start => start_time, :end => end_time)
	predetermined_talks << [timeslot, room_b, nil, nil, true]
	timeslots_to_lock << timeslot


	## Sunday Morning, Part II
	
	num_timeslots = 2
	end_time = Timeslot.generate!(session_no, num_timeslots, end_time, 30.minutes)
	session_no = session_no+num_timeslots	
		
	
	## Lunch
	
	start_time = end_time
	end_time = start_time + 50.minutes
	timeslot_label = 'Lunch'
	timeslot = Timeslot.create(:name => timeslot_label, :start => start_time, :end => end_time)
	predetermined_talks << [timeslot, room_b, nil, nil, true]
	timeslots_to_lock << timeslot
	
	
	## Sunday Afternoon
	
	num_timeslots = 3
	end_time = Timeslot.generate!(session_no, num_timeslots, end_time, 30.minutes)
	session_no = session_no+num_timeslots	
	
	
	## Closing Talk
	
	start_time = end_time
	end_time = start_time + 15.minutes
	timeslot_label = 'Closing Talk'
	timeslot = Timeslot.create(:name => timeslot_label, :start => start_time, :end => end_time)
	predetermined_talks << [timeslot, room_b, "A quick round-up of the weekend.", "The Crew", true]
	timeslots_to_lock << timeslot
	
	
	## Tidy-up
	
	start_time = end_time
	end_time = start_time + 30.minutes
	timeslot_label = 'Tidy-up'
	timeslot = Timeslot.create(:name => timeslot_label, :start => start_time, :end => end_time)
	predetermined_talks << [timeslot, room_a, "A quick zip-round to set the rooms back as they were before we took over.", "Everyone", true]
	timeslots_to_lock << timeslot
	
	
	## Summary of timeslots created
	puts "Total Timeslots: " + Timeslot.all.count.to_s
	puts "ID of first Timeslot: " + Timeslot.all.first.id.to_s
	
	
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
	  talk = Talk.create(:title => timeslot.name, :description => predetermined_talk[2].to_s, :speaker => predetermined_talk[3])
	  
	  #### Set the talk as the timeslot's global talk
	  if (predetermined_talk[4] == true)
	  	puts "Setting talk " + talk.id.to_s + " as global talk for timeslot " + timeslot.id.to_s
	  	timeslot.global_talk_id = talk.id	  	
	  end
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
    
  end
  
end