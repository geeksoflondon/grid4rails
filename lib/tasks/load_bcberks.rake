namespace :db do
  
  desc <<-DESC
  	Drop, create, migrate then seed the database with data for BarcampLondon9
  	This file should contain all the record creation needed to seed the database with its default values.
  	Run using the command 'rake db:load_bcl9
  DESC
  
  task :load_bcberks => [:environment] do
  
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
  	$redis.keys('*').each do |key| $redis.del(key) end
  	
  	puts "Total Timeslots: " + Timeslot.all.count.to_s
  	puts "Total Rooms: " + Room.all.count.to_s
  	puts "Total Slots: " + Slot.all.count.to_s
  	puts "Total Talks: " + Talk.all.count.to_s
  	
  	
  	# Generate Rooms
  	puts "Generating rooms."
  	
  	# Room specs: https://geeksoflondon.basecamphq.com/projects/7251895-barcamp-london-9/posts/52762583/comments
  	# Naming scheme: https://geeksoflondon.basecamphq.com/projects/7251895-barcamp-london-9/cat/73463514/posts
  	
  	room_a = Room.create(
  		{
	  		:name => 'Everywhere', 
	  		:description => 'Any and all rooms (assuming it\'s not out-of-bounds and there\'s no other talk scheduled in it)', 
	  		:short_code => 'any', 
	  		:capacity => 250, 
	  		:include_in_grid => false
		}, 
		:without_protection => true
  	)
  	room_b = Room.create(
  		{
	  		:name => 'The Atrium', 
	  		:description => 'On the ground floor, in the middle of the building. This is where you can chill, chat, watch the tennis or F1 and check the grid.', 
	  		:short_code => 'atr', 
	  		:capacity => 1,  
	  		:facilities => '72" Smart Plasma TV, XBOX 360, Apple TV, Visualiser and The Physical Grid (you are currently viewing The Digital Grid).',
	  		:include_in_grid => false
  		}, 
  		:without_protection => true
  	)
  	
  	## Schedulable Rooms
	room1 = Room.create(
  		{
	  		:name => 'East End', 
	  		:description => 'On the ground floor.', 
	  		:short_code => 'eas', 
	  		:capacity => 24
  		}, 
  		:without_protection => true
  	)
  	room2 = Room.create(
  		{
	  		:name => 'The Arena', 
	  		:description => 'Best A/V Setup in building.  On the ground floor, in the East River zone.', 
	  		:short_code => 'arn', 
	  		:capacity => 48, 
	  		:facilities => 'Projector'
  		}, 
  		:without_protection => true
  	)
  	room3 = Room.create(
  		{
  			:name => 'Blue Room', 
  			:description => 'Simple board room style.  On the ground floor, between the Atrium and the Registration Desk.',  
	  		:short_code => 'blu', 
	  		:capacity => 18, 
	  		:facilities => 'Projector'
  		}, 
  		:without_protection => true
  	)
  	room4 = Room.create(
  		{
  			:name => 'Red Room', 
  			:description => 'On the ground floor, between the Atrium and the Registration Desk.',  
	  		:short_code => 'red', 
	  		:capacity => 18, 
	  		:facilities => 'Projector'
  		}, 
  		:without_protection => true
  	)
  	room5 = Room.create(
  		{
  			:name => 'Green Room', 
  			:description => 'On the ground floor, between the Atrium and the Registration Desk.',  
	  		:short_code => 'gre', 
	  		:capacity => 18, 
	  		:facilities => 'Projector'
  		}, 
  		:without_protection => true
  	)  	
    room6 = Room.create(
    	{
	    	:name => 'Maria Luisa Park', 
	    	:description => 'On the ground floor, off the Atrium, to the left of the Physical Grid.',
	    	:short_code => 'mar', 
  			:capacity => 14,  
  			:facilities => 'No A/V'
		}, 
		:without_protection => true
    )
	room7 = Room.create(
  		{
	  		:name => 'Parc Guinardo', 
	  		:description => 'In the East Quarter, on the first floor.',  
	  		:short_code => 'gui', 
	  		:capacity => 12,    
	  		:facilities => 'Projector'
  		}, 
  		:without_protection => true
  	)
  	room8 = Room.create(
  		{
	  		:name => 'Lab Quarter', 
	  		:description => 'In the East Quarter, on the first floor.', 
	  		:short_code => 'lab', 
	  		:capacity => 30,  
  		}, 
  		:without_protection => true
  	)
  	room9 = Room.create(
  		{
	  		:name => 'Nutall Park', 
	  		:description => 'On the first floor', 
	  		:short_code => 'nut', 
	  		:capacity => 30,
  		}, 
  		:without_protection => true
  	)  	  	
  	room10 = Room.create(
  		{
	  		:name => 'Haynes Park', 
	  		:description => 'In the East River zone, on the first floor.', 
	  		:short_code => 'hay', 
	  		:capacity => 8,  
	  		:facilities => 'Projector'
  		}, 
  		:without_protection => true
  	)
  	room11 = Room.create(
  		{
	  		:name => 'Wimbledon Common', 
	  		:description => 'In the East Quarter, on the first floor.  Watch out for Wombles.',  
	  		:short_code => 'wim', 
	  		:capacity => 8,    
	  		:facilities => 'Projector'
  		}, 
  		:without_protection => true
  	)
  	    	
  	puts "Total Rooms: " + Room.all.count.to_s
  	puts "ID of first Room: " + Room.all.first.id.to_s
  	
	
  	#Generate Timeslots
  	puts "Generating timeslots."
  	predetermined_talks = Array.new
  	timeslots_to_lock = Array.new
  	
  	##Opening Talk
  	
  	start_time = Time.utc(2012, "jul", 7,9,30,00)
  	end_time = start_time + 30.minutes
  	timeslot_label = 'Opening Talk'
  	timeslot = Timeslot.create({:name => timeslot_label, :start => start_time, :end => end_time}, :without_protection => true)
  	predetermined_talks << [timeslot, room_b, "Welcome to Barcamp Berkshire!", "The Crew", true]
  	timeslots_to_lock << timeslot
  	
  	
  	## Grid Population
  	
  	start_time = end_time
  	end_time = start_time + 20.minutes
  	timeslot_label = 'Grid Population'
  	timeslot = Timeslot.create({:name => timeslot_label, :start => start_time, :end => end_time}, :without_protection => true)
  	predetermined_talks << [timeslot, room_a, "Add your talk to the grid", "You", true]
  	timeslots_to_lock << timeslot
  	
  	
  	## Saturday Morning
  		
  	session_no = 1
  	#num_timeslots = 1
  	#end_time = Timeslot.generate!(session_no, num_timeslots, end_time, 25.minutes, 5.minutes)
  	#session_no = session_no+num_timeslots
  	
  	#end_time = end_time + 5.minutes
    num_timeslots = 3
    end_time = Timeslot.generate!(session_no, num_timeslots, end_time, 30.minutes, 5.minutes)
    session_no = session_no+num_timeslots 	
  	
  	
  	## Lunch
  	
  	start_time = end_time
  	end_time = start_time + 1.hour + 30.minutes
  	timeslot_label = 'Lunch'
  	timeslot = Timeslot.create({:name => timeslot_label, :start => start_time, :end => end_time}, :without_protection => true)
  	predetermined_talks << [timeslot, room_b, nil, nil, true]
  	timeslots_to_lock << timeslot
  	
  	
  	## Saturday Afternoon, Part I
  	
  	num_timeslots = 4
  	end_time = Timeslot.generate!(session_no, num_timeslots, end_time, 40.minutes, 10.minutes)
  	session_no = session_no+num_timeslots	
  
  
    ## Tea Break
    
    start_time = end_time
    end_time = start_time + 20.minutes
    timeslot_label = 'Tea Break'
    timeslot = Timeslot.create({:name => timeslot_label, :start => start_time, :end => end_time}, :without_protection => true)
    predetermined_talks << [timeslot, room_b, nil, nil, true]
    timeslots_to_lock << timeslot
  
  
    ## Saturday Afternoon, Part II
    
  	num_timeslots = 2
  	end_time = Timeslot.generate!(session_no, num_timeslots, end_time, 25.minutes, 10.minutes)
  	session_no = session_no+num_timeslots	
  
  	
  	## Dinner
  	
  	start_time = end_time
  	end_time = start_time + 90.minutes
  	timeslot_label = 'Dinner'
  	timeslot = Timeslot.create({:name => timeslot_label, :start => start_time, :end => end_time}, :without_protection => true)
  	predetermined_talks << [timeslot, room_b, nil, nil, true]
  	timeslots_to_lock << timeslot
  	
  	
  	## Saturday Evening
  	
  	num_timeslots = 2
  	end_time = Timeslot.generate!(session_no, num_timeslots, end_time, 25.minutes, 10.minutes)
  	session_no = session_no+num_timeslots	
  	
  	
  	## Saturday Night
  	
  	start_time = end_time
  	end_time = Time.utc(2012, "jul", 8,7,00,00)
  	timeslot_label = 'Games, etc.'
  	timeslot = Timeslot.create({:name => timeslot_label, :start => start_time, :end => end_time}, :without_protection => true)
  	predetermined_talks << [timeslot, room_a, nil, nil, true]
  	timeslots_to_lock << timeslot
  	
  	
  	## Breakfast
  	
  	start_time = end_time
  	end_time = start_time + 120.minutes
  	timeslot_label = 'Breakfast'
  	timeslot = Timeslot.create({:name => timeslot_label, :start => start_time, :end => end_time}, :without_protection => true)
  	predetermined_talks << [timeslot, room_b, nil, nil, true]
  	timeslots_to_lock << timeslot
  	
  	
  	## Sunday Morning, Part I
  	
  	num_timeslots = 2
  	end_time = Timeslot.generate!(session_no, num_timeslots, end_time, 40.minutes, 10.minutes)
  	session_no = session_no+num_timeslots
  	
  	end_time = end_time + 10.minutes
  	num_timeslots = 3
    end_time = Timeslot.generate!(session_no, num_timeslots, end_time, 20.minutes, 10.minutes)
    session_no = session_no+num_timeslots	
  	  		
  	
  	## Lunch
  	
  	start_time = end_time
  	end_time = start_time + 60.minutes
  	timeslot_label = 'Lunch'
  	timeslot = Timeslot.create({:name => timeslot_label, :start => start_time, :end => end_time}, :without_protection => true)
  	predetermined_talks << [timeslot, room_b, nil, nil, true]
  	timeslots_to_lock << timeslot
  	
  	
  	## Sunday Afternoon
  	
  	num_timeslots = 3
  	end_time = Timeslot.generate!(session_no, num_timeslots, end_time, 30.minutes, 10.minutes)
  	session_no = session_no+num_timeslots	
  	
  	
  	## Closing Talk
  	  	  
  	start_time = end_time + 10.minutes
  	end_time = start_time + 15.minutes
  	timeslot_label = 'Closing Talk'
  	timeslot = Timeslot.create({:name => timeslot_label, :start => start_time, :end => end_time}, :without_protection => true)
  	predetermined_talks << [timeslot, room_b, "A quick round-up of the weekend.", "The Crew", true]
  	timeslots_to_lock << timeslot
  	
  	
  	## Tidy-up
  	
  	start_time = end_time
  	end_time = start_time + 30.minutes
  	timeslot_label = 'Tidy-up'
  	timeslot = Timeslot.create({:name => timeslot_label, :start => start_time, :end => end_time}, :without_protection => true)
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
  	  talk = Talk.create({:title => timeslot.name, :description => predetermined_talk[2].to_s, :speaker => predetermined_talk[3]}, :without_protection => true)
  	  
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