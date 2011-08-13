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
Room.create(:name => 'London Bridge', :description => 'The horrible skanky room that smells of piss.', :short_code => 'lbg')
Room.create(:name => 'Paddington', :description => 'A room.', :short_code => 'pad')
Room.create(:name => 'Kings Cross', :description => 'A room.', :short_code => 'kgx')
Room.create(:name => 'Marylebone', :description => 'A room.', :short_code => 'mar')
Room.create(:name => 'Euston', :description => 'Has a roof', :short_code => 'eus')
Room.create(:name => 'Victoria', :description => 'old station from the 80s', :short_code => 'vic')
Room.create(:name => 'Waterloo', :description => 'the wet station', :short_code => 'wat')
Room.create(:name => 'Charing Cross', :description => 'southbank mess', :short_code => 'chx')

#Generate Timeslots

##Today at 9am
time = Time.now
start_time = Time.local(time.strftime("%Y"), time.strftime("%b"), time.strftime("%d"), 9,00,00)
end_time = start_time + 1.hour

Timeslot.create(:name => 'Opening Talk', :start => start_time, :end => end_time)

num_timeslots = 28

i = 0
while i < num_timeslots
  
  start_time = start_time + 1.hour
  end_time = start_time + 1.hour
  
  if (i == 4 || i == 8 || i == 12 || i == 16 || i == 20 || i == 24)
    Timeslot.create(:name => "Break", :start => start_time, :end => end_time)
  else
    Timeslot.create(:name => "Session #{i}", :start => start_time, :end => end_time)
  end
  
  i = i+1
  
end

Timeslot.create(:name => "Closing Talk", :start => start_time+1.hour, :end => end_time+1.hour)

#Generate Slots
slots = Slot.generate!

#Generate Talks

talks = [
  {:title => 'LifestyleLinking Open Source Project', :speaker => 'aboynejames'},
  {:title => 'Simple Data', :speaker => 'John Doe'},
  {:title => 'Set, Suguru, and Fluxx', :speaker => 'Ryan Alexander'},
  {:title => 'Hack 3D', :speaker => 'Ketan Majmudar'},
  {:title => 'What network APIs would you like from giffgaff', :speaker => 'Vincent Boon'},
  {:title => 'JQuery tips & tricks: all sorts of awesome', :speaker => 'Jack Franklin'},
  {:title => 'Control your remote control 40mph car from your iPhone or iPad', :speaker => 'Jack Black'},
  {:title => 'One year running it all on the cloud', :speaker => 'Alistair Hann'},
  {:title => 'Running Meetups using Social Networks', :speaker => 'Nathan O\'Hanlon'},
  {:title => 'Simple node.js apps without web sockets', :speaker => 'Robbie Clutton'},
]

Slot.all.each do |slot|

  if slot.timeslot.name == 'Break'
    Talk.create(:title => 'Break', :locked => true, :slot_id => slot.id)
  elsif slot.timeslot.name == 'Opening Talk'
    Talk.create(:title => 'Opening Talk', :locked => true, :slot_id => slot.id)
  elsif slot.timeslot.name == 'Closing Talk'
    Talk.create(:title => 'Closing Talk', :locked => true, :slot_id => slot.id)
  elsif rand(4) < 2
    talk = talks[rand(9)]
    talk['slot_id'] = slot.id
    t = Talk.create(talk)
  end

end