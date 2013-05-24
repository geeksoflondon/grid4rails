namespace :db do
  
  desc <<-DESC
    Drop, create, migrate then seed the database with data for BarcampLondon9
    This file should contain all the record creation needed to seed the database with its default values.
    Run using the command 'rake db:load_bcl9
  DESC
  
  task :load_o2barcamp => [:environment] do
  
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
    
    ## Schedulable Rooms
    room1 = Room.create(
        {
          :name => 'Whittington Park (GEE)', 
          :description => 'In the East Quarter, on the first floor.',  
          :short_code => 'gui', 
          :capacity => 12,    
          :facilities => 'Projector'
        }, 
        :without_protection => true
    )
    room2 = Room.create(
      {
        :name => 'The Arena (GER)', 
        :description => 'Best A/V Setup in building.  On the ground floor, in the East River zone.', 
        :short_code => 'arn', 
        :capacity => 48, 
        :facilities => 'Projector'
      }, 
      :without_protection => true
    )
    room3 = Room.create(
      {
        :name => 'Blue Room (GER)', 
        :description => 'Simple board room style.  On the ground floor, between the Atrium and the Registration Desk.',  
        :short_code => 'blu', 
        :capacity => 18, 
        :facilities => 'Projector'
      }, 
      :without_protection => true
    )
    room4 = Room.create(
      {
        :name => 'Palmer Park (2EE)', 
        :description => 'On the ground floor, between the Atrium and the Registration Desk.',  
        :short_code => 'red', 
        :capacity => 18, 
        :facilities => 'Projector'
      }, 
      :without_protection => true
    )
    room5 = Room.create(
      {
        :name => 'Cooill y Ree Gardens (2EE)', 
        :description => 'On the ground floor, between the Atrium and the Registration Desk.',  
        :short_code => 'gre', 
        :capacity => 18, 
        :facilities => 'Projector'
      }, 
      :without_protection => true
    )   
    room6 = Room.create(
      {
        :name => 'Oak Hill Park (GEQ)', 
        :description => 'On the ground floor, off the Atrium, to the left of the Physical Grid.',
        :short_code => 'mar', 
        :capacity => 14,  
        :facilities => 'No A/V'
    }, 
    :without_protection => true
    )
    room7 = Room.create(
      {
        :name => 'Lab Area', 
        :description => 'In the East Quarter, on the second floor.', 
        :short_code => 'lab', 
        :capacity => 30,  
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
    
    start_time = Time.utc(2013, "jun", 16,9,30,00)
    end_time = start_time + 30.minutes
    timeslot_label = 'Opening Talk'
    timeslot = Timeslot.create({:name => timeslot_label, :start => start_time, :end => end_time}, :without_protection => true)
    predetermined_talks << [timeslot, room2, "Welcome to Barcamp O2!", "The Crew", true]
    timeslots_to_lock << timeslot
    
    ## Saturday Morning
      
    session_no = 1
    #num_timeslots = 1
    #end_time = Timeslot.generate!(session_no, num_timeslots, end_time, 25.minutes, 5.minutes)
    #session_no = session_no+num_timeslots
    
    #end_time = end_time + 5.minutes
    num_timeslots = 12
    end_time = Timeslot.generate!(session_no, num_timeslots, end_time, 25.minutes, 5.minutes)
    session_no = session_no+num_timeslots   
    
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