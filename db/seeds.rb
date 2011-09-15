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
Room.create(:name => 'London Bridge', :description => 'The horrible skanky room that smells of piss.', :short_code => 'lbg', :capacity => 10)
Room.create(:name => 'Paddington', :description => 'A room.', :short_code => 'pad', :capacity => 10)
Room.create(:name => 'Kings Cross', :description => 'A room.', :short_code => 'kgx', :capacity => 10)
Room.create(:name => 'Marylebone', :description => 'A room.', :short_code => 'mar', :capacity => 10)
Room.create(:name => 'Euston', :description => 'Has a roof', :short_code => 'eus', :capacity => 10)
Room.create(:name => 'Victoria', :description => 'old station from the 80s', :short_code => 'vic', :capacity => 10)
Room.create(:name => 'Waterloo', :description => 'the wet station', :short_code => 'wat', :capacity => 10)
Room.create(:name => 'Charing Cross', :description => 'southbank mess', :short_code => 'chx', :capacity => 10)

#Generate Timeslots

##Today at 9am
time = Time.now
start_time = Time.utc(time.strftime("%Y"), time.strftime("%b"), time.strftime("%d"), 9,00,00)
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
  {:title => 'LifestyleLinking Open Source Project', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec blandit mauris a sem porttitor feugiat. Nam pellentesque leo magna. Lorem.', :speaker => 'aboynejames'},
  {:title => 'Simple Data', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec blandit mauris a sem porttitor feugiat. Nam pellentesque leo magna. Lorem.', :speaker => 'John Doe'},
  {:title => 'Set, Suguru, and Fluxx', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec blandit mauris a sem porttitor feugiat. Nam pellentesque leo magna. Lorem.', :speaker => 'Ryan Alexander'},
  {:title => 'Hack 3D', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec blandit mauris a sem porttitor feugiat. Nam pellentesque leo magna. Lorem.', :speaker => 'Ketan Majmudar'},
  {:title => 'What network APIs would you like from giffgaff', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec blandit mauris a sem porttitor feugiat. Nam pellentesque leo magna. Lorem.', :speaker => 'Vincent Boon'},
  {:title => 'JQuery tips & tricks: all sorts of awesome', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec blandit mauris a sem porttitor feugiat. Nam pellentesque leo magna. Lorem.', :speaker => 'Jack Franklin'},
  {:title => 'Control your remote control 40mph car from your iPhone or iPad', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec blandit mauris a sem porttitor feugiat. Nam pellentesque leo magna. Lorem.', :speaker => 'Jack Black'},
  {:title => 'One year running it all on the cloud', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec blandit mauris a sem porttitor feugiat. Nam pellentesque leo magna. Lorem.', :speaker => 'Alistair Hann'},
  {:title => 'Running Meetups using Social Networks', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec blandit mauris a sem porttitor feugiat. Nam pellentesque leo magna. Lorem.', :speaker => 'Nathan O\'Hanlon'},
  {:title => 'Simple node.js apps without web sockets', :description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec blandit mauris a sem porttitor feugiat. Nam pellentesque leo magna. Lorem.', :speaker => 'Robbie Clutton'},
]

Slot.all.each do |slot|

  if slot.timeslot.name == 'Break'
    t = Talk.create(:title => 'Break')
    slot.locked = true
    slot.talk_id = t.id
    slot.save
  elsif slot.timeslot.name == 'Opening Talk'
    t = Talk.create(:title => 'Opening Talk')
    slot.locked = true
    slot.talk_id = t.id
    slot.save
  elsif slot.timeslot.name == 'Closing Talk'
    t =Talk.create(:title => 'Closing Talk')
    slot.locked = true
    slot.talk_id = t.id
    slot.save
  elsif rand(4) < 2
    talk = talks[rand(9)]
    t = Talk.create(talk)
    slot.talk_id = t.id
    slot.save
  end

end