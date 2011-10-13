# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

#Firstly lets destroy anything we can find
puts "Deleting existing rooms, timeslots, slots and talks."
Room.delete_all
Timeslot.delete_all
Slot.delete_all
Talk.delete_all

puts "Total Timeslots: " + Timeslot.all.count.to_s
puts "Total Rooms: " + Room.all.count.to_s
puts "Total Slots: " + Slot.all.count.to_s
puts "Total Talks: " + Talk.all.count.to_s


#Generate Rooms
puts "Generating rooms."
Room.create(:name => 'Count Dracula', :description => 'Xth Floor, straight ahead towards Old Trafford. Semi-circle of chairs against the curved glass wall.', :short_code => 'cdr', :capacity => 30, :facilities => 'TV')
Room.create(:name => 'Frankenstein\'s Monster', :description => 'Xth Floor, large auditorium-like space to the left as you face Old Trafford. Where the welcome talk took place.', :short_code => 'frm', :capacity => 100, :facilities => 'TV')
Room.create(:name => 'The Luggage', :description => 'Xth Floor, in the rear-left corner as you face Old Trafford.', :short_code => 'lug', :capacity => 20, :facilities => 'Projector')
Room.create(:name => 'Godzilla', :description => 'Xth Floor, in the front-left corner as you face Old Trafford.', :short_code => 'god', :capacity => 50, :facilities => 'Whiteboard')
Room.create(:name => 'Tribbles', :description => 'Xth Floor, cosy armchairs, to the right as you face Old Trafford, behind the kitchen.', :short_code => 'trb', :capacity => 15, :facilities => 'Projector, whiteboard')
Room.create(:name => 'Pikachu', :description => 'Xth Floor, in the front-left corner as you face Old Trafford. Next to Bagpuss.', :short_code => 'pik', :capacity => 20)
Room.create(:name => 'Casper', :description => 'Xth Floor, in the front-left corner as you face Old Trafford. Next to Redhead.', :short_code => 'cas', :capacity => 30, :facilities => 'TV, whiteboard')

puts "Total Rooms: " + Room.all.count.to_s
puts "ID of first Room: " + Room.all.first.id.to_s


#Generate Timeslots
puts "Generating timeslots."
predetermined_talk_names = Array.new

##Opening Talk

start_time = Time.utc(2011, "oct", 29,9,30,00)
end_time = start_time + 40.minutes
timeslot_label = 'Opening Talk'
Timeslot.create(:name => timeslot_label, :start => start_time, :end => end_time)
predetermined_talk_names << timeslot_label


## Grid Population

start_time = end_time
end_time = start_time + 20.minutes
timeslot_label = 'Grid Population'
Timeslot.create(:name => timeslot_label, :start => start_time, :end => end_time)
predetermined_talk_names << timeslot_label


## Saturday Morning

num_timeslots = 3
session_no = 1

i = 0
while i < num_timeslots

  start_time = end_time
  end_time = start_time + 20.minutes

  Timeslot.create(:name => "Session #{session_no}", :start => start_time, :end => end_time)

  i = i+1
  session_no = session_no+1
  end_time = end_time + 10.minutes

end


## Lunch

start_time = end_time
end_time = start_time + 1.hour
timeslot_label = 'Lunch'
Timeslot.create(:name => timeslot_label, :start => start_time, :end => end_time)
predetermined_talk_names << timeslot_label


## Saturday Afternoon

num_timeslots = 11

i = 0
while i < num_timeslots

  start_time = end_time
  end_time = start_time + 20.minutes

  Timeslot.create(:name => "Session #{session_no}", :start => start_time, :end => end_time)

  i = i+1
  session_no = session_no+1

  end_time = end_time + 10.minutes

end


## Dinner

start_time = end_time
end_time = start_time + 90.minutes
timeslot_label = 'Dinner'
Timeslot.create(:name => timeslot_label, :start => start_time, :end => end_time)
predetermined_talk_names << timeslot_label


## Saturday Evening

num_timeslots = 2

i = 0
while i < num_timeslots

  start_time = end_time
  end_time = start_time + 20.minutes

  Timeslot.create(:name => "Session #{session_no}", :start => start_time, :end => end_time)

  i = i+1
  session_no = session_no+1

  end_time = end_time + 10.minutes

end


## Saturday Night

start_time = end_time
end_time = Time.utc(2011, "oct", 30,7,30,00)
timeslot_label = 'Games, etc.'
Timeslot.create(:name => timeslot_label, :start => start_time, :end => end_time)
predetermined_talk_names << timeslot_label


## Breakfast

start_time = end_time
end_time = start_time + 90.minutes
timeslot_label = 'Breakfast'
Timeslot.create(:name => timeslot_label, :start => start_time, :end => end_time)
predetermined_talk_names << timeslot_label


## Sunday Morning

num_timeslots = 4

i = 0
while i < num_timeslots

  start_time = end_time
  end_time = start_time + 20.minutes

  Timeslot.create(:name => "Session #{session_no}", :start => start_time, :end => end_time)

  i = i+1
  session_no = session_no+1

  end_time = end_time + 10.minutes

end


## Lunch

start_time = end_time
end_time = start_time + 1.hour
timeslot_label = 'Lunch'
Timeslot.create(:name => timeslot_label, :start => start_time, :end => end_time)


## Sunday Afternoon

num_timeslots = 4

i = 0
while i < num_timeslots

  start_time = end_time
  end_time = start_time + 20.minutes

  Timeslot.create(:name => "Session #{session_no}", :start => start_time, :end => end_time)

  i = i+1
  session_no = session_no+1

  if (i == (num_timeslots - 1))
  	end_time = end_time + 15.minutes
  else
  	end_time = end_time + 10.minutes
  end

end


## Closing Talk

start_time = end_time
end_time = start_time + 15.minutes
timeslot_label = 'Closing Talk'
Timeslot.create(:name => timeslot_label, :start => start_time, :end => end_time)
predetermined_talk_names << timeslot_label


## Clean-up

start_time = end_time
end_time = start_time + 30.minutes
timeslot_label = 'Clean-up'
Timeslot.create(:name => timeslot_label, :start => start_time, :end => end_time)
predetermined_talk_names << timeslot_label


## Summary of timeslots created
puts "Total Timeslots: " + Timeslot.all.count.to_s
puts "ID of first Timeslot: " + Timeslot.all.first.id.to_s


# Generate Slots
puts "Generating slots."
Slot.generate!

puts "Total Slots: " + Slot.all.count.to_s


# Generate pre-determined talks
puts "Generating pre-determined talks."
puts "Total Pre-determined Talk Titles: " + predetermined_talk_names.count.to_s

## Loop through all timeslots
Timeslot.all.each do |timeslot|

  ### Check whether the name of the current timeslot is in the list of pre-determined talk names
  if (predetermined_talk_names.include?(timeslot.name))

  	puts "Timeslot Name: " + timeslot.name

  	#### A pre-determined talk needs to be assigned to each of the slots in this timeslot
    timeslot.slots.each do |slot|
    
      ##### Create a talk with the same name as the timeslot
      talk = Talk.create(:title => timeslot.name)
    
      ##### Assign the talk to the current slot
      puts "Assigning talk " + talk.id.to_s + " to slot " + slot.id.to_s
      talk.slot = slot
	  talk.save

	  ##### Lock the slot
      slot.locked = true
      slot.save
      
    end
  end

end

puts "Total Talks: " + Talk.all.count.to_s

# Confirm seed completed
puts "Seeding complete."