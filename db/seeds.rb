# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create({[{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create({name: 'Emanuel', city: cities.first)


#Firstly lets destroy anything we can find
puts "Deleting existing rooms, timeslots, slots and talks."
Room.delete_all
Timeslot.delete_all
Slot.delete_all
Talk.delete_all

#Clear down redis
$redis.keys('*').each do |key| $redis.del(key) end

puts "Total Timeslots: " + Timeslot.all.count.to_s
puts "Total Rooms: " + Room.all.count.to_s
puts "Total Slots: " + Slot.all.count.to_s
puts "Total Talks: " + Talk.all.count.to_s


# Generate Rooms
puts "Generating rooms."

room_a = Room.create({
  	:name => 'Everywhere', 
  	:description => 'Any and all rooms (assuming it\'s not out-of-bounds and there\'s no other talk scheduled in it)', 
  	:short_code => 'any', 
  	:capacity => 250, 
  	:include_in_grid => false
	}, :without_protection => true
)
room_b = Room.create({
	:name => 'Thing', 
	:description => 'The huge room in the basement; down the stairs and to the left.', 
	:short_code => 'thg', 
	:capacity => 250,  
	:include_in_grid => false
	}, :without_protection => true
)
room1 = Room.create({
	:name => 'Count Dracula', 
	:description => 'Basement.', 
	:short_code => 'cdr', 
	:capacity => 40, 
	:facilities => 'tbd'
}, :without_protection => true
)
room2 = Room.create({
	:name => 'Frankenstein\'s Monster', 
	:description => 'Basement', 
	:short_code => 'frm', 
	:capacity => 40, 
	:facilities => 'tbd'
}, :without_protection => true
)
room3 = Room.create({
	:name => 'Audrey II', 
	:description => 'Basement', 
	:short_code => 'aud', 
	:capacity => 40, 
	:facilities => 'tbd'
}, :without_protection => true
)
room4 = Room.create({
	:name => 'The Luggage', 
	:description => 'First floor.', 
	:short_code => 'lug', 
	:capacity => 40, 
	:facilities => 'tbd'
}, :without_protection => true
)
room5 = Room.create({
	:name => 'Godzilla', 
	:description => 'First floor.', 
	:short_code => 'god', 
	:capacity => 30, 
	:facilities => 'tbd'
}, :without_protection => true
)
room6 = Room.create({
	:name => 'Tribbles', 
	:description => 'First floor.', 
	:short_code => 'trb', 
	:capacity => 30,
	:facilities => 'tbd'
}, :without_protection => true
)
room7 = Room.create({
	:name => 'Pikachu', 
	:description => 'First floor.', 
	:short_code => 'pik', 
	:capacity => 30, 
	:facilities => 'tbd'
}, :without_protection => true
)
room8 = Room.create({
	:name => 'Casper', 
	:description => 'Second floor.', 
	:short_code => 'cas', 
	:capacity => 30, 
	:facilities => 'tbd'
}, :without_protection => true
)
room9 = Room.create({
	:name => 'Weeping Angel', 
	:description => 'Second floor.', 
	:short_code => 'ang', 
	:capacity => 30, 
	:facilities => 'tbd'
}, :without_protection => true
)
room10 = Room.create({
	:name => 'Edward Scissorhands', 
	:description => 'Second floor.', 
	:short_code => 'slh', 
	:capacity => 30, 
	:facilities => 'scr'
}, :without_protection => true
)

puts "Total Rooms: " + Room.all.count.to_s
puts "ID of first Room: " + Room.all.first.id.to_s


#Generate Timeslots
puts "Generating timeslots."
predetermined_talks = Array.new
timeslots_to_lock = Array.new

##Opening Talk

timeslot_label = 'Opening Talk'
timeslot = Timeslot.create(
  {
    :name => timeslot_label, 
  	:start => Time.utc(2011, "oct", 15,9,30,00), 
  	:end => Time.utc(2011, "oct", 15,10,10,00)
	},
	:without_protection => true  
)
predetermined_talks << [timeslot, room_b, "Welcome to BarcampLondon9!", "The Crew"]
timeslots_to_lock << timeslot


## Grid Population

timeslot_label = 'Grid Population'
timeslot = Timeslot.create({
	:name => timeslot_label, 
	:start => Time.utc(2011, "oct", 15,10,10,00), 
	:end => Time.utc(2011, "oct", 15,10,30,00)
},
  :without_protection => true
)
predetermined_talks << [timeslot, room_a, "Add your talk to the grid", "You"]
timeslots_to_lock << timeslot


## Saturday Morning
		
Timeslot.create({
	:name => "Session 1", 
	:start => Time.utc(2011, "oct", 15,10,30,00), 
	:end => Time.utc(2011, "oct", 15,10,50,00)
},
  :without_protection => true
)
Timeslot.create({
	:name => "Session 2", 
	:start => Time.utc(2011, "oct", 15,11,00,00), 
	:end => Time.utc(2011, "oct", 15,11,20,00)
},
  :without_protection => true
)
Timeslot.create({
	:name => "Session 3", 
	:start => Time.utc(2011, "oct", 15,11,30,00), 
	:end => Time.utc(2011, "oct", 15,11,50,00)
},
  :without_protection => true
)


## Lunch

timeslot_label = 'Lunch'
timeslot = Timeslot.create({
	:name => timeslot_label, 
	:start => Time.utc(2011, "oct", 15,12,00,00), 
	:end => Time.utc(2011, "oct", 15,13,00,00)
},
  :without_protection => true
)
predetermined_talks << [timeslot, room_b, nil, nil]
timeslots_to_lock << timeslot


## Saturday Afternoon, Part I

Timeslot.create({
	:name => "Session 4", 
	:start => Time.utc(2011, "oct", 15,13,00,00), 
	:end => Time.utc(2011, "oct", 15,13,20,00)
},
  :without_protection => true
)
Timeslot.create({
	:name => "Session 5", 
	:start => Time.utc(2011, "oct", 15,13,30,00), 
	:end => Time.utc(2011, "oct", 15,13,50,00)
},
  :without_protection => true
)
Timeslot.create({
	:name => "Session 6", 
	:start => Time.utc(2011, "oct", 15,14,00,00), 
	:end => Time.utc(2011, "oct", 15,14,20,00)
},
  :without_protection => true
)
Timeslot.create({
	:name => "Session 7", 
	:start => Time.utc(2011, "oct", 15,14,30,00), 
	:end => Time.utc(2011, "oct", 15,14,50,00)
},
  :without_protection => true
)	
Timeslot.create({
	:name => "Session 8", 
	:start => Time.utc(2011, "oct", 15,15,00,00), 
	:end => Time.utc(2011, "oct", 15,15,20,00)
},
  :without_protection => true
)
Timeslot.create({
	:name => "Session 9", 
	:start => Time.utc(2011, "oct", 15,15,30,00), 
	:end => Time.utc(2011, "oct", 15,15,50,00)
},
  :without_protection => true
)
Timeslot.create({
	:name => "Session 10", 
	:start => Time.utc(2011, "oct", 15,16,00,00), 
	:end => Time.utc(2011, "oct", 15,16,20,00)
},
  :without_protection => true
)
Timeslot.create({
	:name => "Session 11", 
	:start => Time.utc(2011, "oct", 15,16,30,00), 
	:end => Time.utc(2011, "oct", 15,16,50,00)
},
  :without_protection => true
)
Timeslot.create({
	:name => "Session 12", 
	:start => Time.utc(2011, "oct", 15,17,00,00), 
	:end => Time.utc(2011, "oct", 15,17,20,00)
},
  :without_protection => true
)
Timeslot.create({
	:name => "Session 13", 
	:start => Time.utc(2011, "oct", 15,17,30,00), 
	:end => Time.utc(2011, "oct", 15,17,50,00)
},
  :without_protection => true
)
Timeslot.create({
	:name => "Session 14", 
	:start => Time.utc(2011, "oct", 15,18,00,00), 
	:end => Time.utc(2011, "oct", 15,18,20,00)
},
  :without_protection => true
)


## Dinner

timeslot_label = 'Dinner'
timeslot = Timeslot.create({
	:name => timeslot_label, 
	:start => Time.utc(2011, "oct", 15,18,30,00), 
	:end => Time.utc(2011, "oct", 15,20,00,00)
},
  :without_protection => true
)
predetermined_talks << [timeslot, room_b, nil, nil]
timeslots_to_lock << timeslot


## Saturday Evening

Timeslot.create({
	:name => "Session 15", 
	:start => Time.utc(2011, "oct", 15,20,00,00), 
	:end => Time.utc(2011, "oct", 15,20,20,00)
},
  :without_protection => true
)
Timeslot.create({
	:name => "Session 16", 
	:start => Time.utc(2011, "oct", 15,20,30,00), 
	:end => Time.utc(2011, "oct", 15,20,50,00)
},
  :without_protection => true
)


## Saturday Night

timeslot_label = 'Games, etc.'
timeslot = Timeslot.create({
	:name => timeslot_label, 
	:start => Time.utc(2011, "oct", 15,21,00,00), 
	:end => Time.utc(2011, "oct", 16,6,30,00)
},
  :without_protection => true
)
predetermined_talks << [timeslot, room_a, nil, nil]
timeslots_to_lock << timeslot


## Breakfast

timeslot_label = 'Breakfast'
timeslot = Timeslot.create({
	:name => timeslot_label, 
	:start => Time.utc(2011, "oct", 16,6,30,00), 
	:end => Time.utc(2011, "oct", 16,8,00,00)
},
  :without_protection => true
)
predetermined_talks << [timeslot, room_b, nil, nil]
timeslots_to_lock << timeslot


## Sunday Morning, Part I

Timeslot.create({
	:name => "Session 17", 
	:start => Time.utc(2011, "oct", 16,8,00,00), 
	:end => Time.utc(2011, "oct", 16,8,20,00)
},
  :without_protection => true
)
Timeslot.create({
	:name => "Session 18", 
	:start => Time.utc(2011, "oct", 16,8,30,00), 
	:end => Time.utc(2011, "oct", 16,8,50,00)
},
  :without_protection => true
)
Timeslot.create({
	:name => "Session 19", 
	:start => Time.utc(2011, "oct", 16,9,00,00), 
	:end => Time.utc(2011, "oct", 16,9,20,00)
},
  :without_protection => true
)
Timeslot.create({
	:name => "Session 20", 
	:start => Time.utc(2011, "oct", 16,9,30,00), 
	:end => Time.utc(2011, "oct", 16,9,50,00)
},
  :without_protection => true
)	


## Lunch

timeslot_label = 'Lunch'
timeslot = Timeslot.create({
	:name => timeslot_label, 
	:start => Time.utc(2011, "oct", 16,10,00,00), 
	:end => Time.utc(2011, "oct", 16,11,00,00)
},
  :without_protection => true
)
predetermined_talks << [timeslot, room_b, nil, nil]
timeslots_to_lock << timeslot


## Sunday Afternoon

Timeslot.create({
	:name => "Session 21", 
	:start => Time.utc(2011, "oct", 16,11,00,00), 
	:end => Time.utc(2011, "oct", 16,11,20,00)
},
  :without_protection => true
)
Timeslot.create({
	:name => "Session 22", 
	:start => Time.utc(2011, "oct", 16,11,30,00), 
	:end => Time.utc(2011, "oct", 16,11,50,00)
},
  :without_protection => true
)
Timeslot.create({
	:name => "Session 23", 
	:start => Time.utc(2011, "oct", 16,12,00,00), 
	:end => Time.utc(2011, "oct", 16,12,20,00)
},
  :without_protection => true
)
Timeslot.create({
	:name => "Session 24", 
	:start => Time.utc(2011, "oct", 16,12,30,00), 
	:end => Time.utc(2011, "oct", 16,12,50,00)
},
  :without_protection => true
)	


## Closing Talk

timeslot_label = 'Closing Talk'
timeslot = Timeslot.create({
	:name => timeslot_label, 
	:start => Time.utc(2011, "oct", 16,13,00,00), 
	:end => Time.utc(2011, "oct", 16,13,15,00)
},
  :without_protection => true
)
predetermined_talks << [timeslot, room_b, "A quick round-up of the weekend.", "The Crew"]
timeslots_to_lock << timeslot


## Tidy-up

timeslot_label = 'Tidy-up'
timeslot = Timeslot.create({
	:name => timeslot_label, 
	:start => Time.utc(2011, "oct", 16,13,15,00), 
	:end => Time.utc(2011, "oct", 16,13,45,00)
},
  :without_protection => true
)
predetermined_talks << [timeslot, room_a, "A quick zip-round to set the rooms back as they were before we took over.", "Everyone"]
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
  talk = Talk.create({:title => timeslot.name, :description => predetermined_talk[2], :speaker => predetermined_talk[3]}, :without_protection => true)
  
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