# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

#Firstly lets destroy anything we can find
Room.delete_all
Timeslot.delete_all
Slot.delete_all
Talk.delete_all
User.delete_all

#Generate Rooms
Room.create(:name => 'Red Dwarf', :description => '5th Floor, straight ahead towards Old Trafford. Semi-circle of chairs against the curved glass wall.', :short_code => 'rdw', :capacity => 30, :facilities => 'TV')
Room.create(:name => 'Doctor Who', :description => '5th Floor, large auditorium-like space to the left as you face Old Trafford. Where the welcome talk took place.', :short_code => 'drw', :capacity => 100, :facilities => 'TV')
Room.create(:name => 'Inside Out', :description => '5th Floor, in the rear-left corner as you face Old Trafford.', :short_code => 'ino', :capacity => 20, :facilities => 'Projector')
Room.create(:name => 'Attachments', :description => '5th Floor, in the front-left corner as you face Old Trafford.', :short_code => 'att', :capacity => 50, :facilities => 'Whiteboard')
Room.create(:name => 'Torchwood', :description => '4th Floor, cosy armchairs, to the right as you face Old Trafford, behind the kitchen.', :short_code => 'twd', :capacity => 15, :facilities => 'Projector, whiteboard')
Room.create(:name => 'Bagpuss', :description => '4th Floor, in the front-left corner as you face Old Trafford. Next to Bagpuss.', :short_code => 'bgp', :capacity => 20)
Room.create(:name => 'Redhead', :description => '4th Floor, in the front-left corner as you face Old Trafford. Next to Redhead.', :short_code => 'rdh', :capacity => 30, :facilities => 'TV, whiteboard')

#Generate Timeslots

locked_slots = Array.new

##Opening Talk

start_time = Time.utc(2011, "sep", 17,9,30,00)
end_time = start_time + 40.minutes
label = 'Opening Talk'
Timeslot.create(:name => label, :start => start_time, :end => end_time)
locked_slots << label


## Grid Population

start_time = end_time
end_time = start_time + 20.minutes
label = 'Grid Population'
Timeslot.create(:name => label, :start => start_time, :end => end_time)
locked_slots << label


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
label = 'Lunch'
Timeslot.create(:name => label, :start => start_time, :end => end_time)
locked_slots << label


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
label = 'Dinner'
Timeslot.create(:name => label, :start => start_time, :end => end_time)
locked_slots << label


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
end_time = Time.utc(2011, "sep", 18,7,30,00)
label = 'Games, etc.'
Timeslot.create(:name => label, :start => start_time, :end => end_time)
locked_slots << label


## Breakfast

start_time = end_time
end_time = start_time + 90.minutes
label = 'Breakfast'
Timeslot.create(:name => label, :start => start_time, :end => end_time)
locked_slots << label


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
label = 'Lunch'
Timeslot.create(:name => label, :start => start_time, :end => end_time)


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
label = 'Closing Talk'
Timeslot.create(:name => label, :start => start_time, :end => end_time)
locked_slots << label


## Clean-up

start_time = end_time
end_time = start_time + 30.minutes
label = 'Clean-up'
Timeslot.create(:name => label, :start => start_time, :end => end_time)
locked_slots << label


#Generate Slots

puts Timeslot.all.count
puts Timeslot.all.first.id
puts Room.all.count
puts Room.all.first.id
puts Slot.all.count  

Slot.generate!

puts Slot.all.count

Timeslot.all.each do |timeslot|

	if (locked_slots.include?(timeslot.name))
	
		timeslot.slots.each do |slot|
			
			talk = Talk.create(:title => timeslot.name)
			slot.talk_id = talk.id
			slot.locked = true
			slot.save
		
		end			
	
	end

end