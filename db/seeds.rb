# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

slots = Slot.generate!

Slot.all.each do |slot|

  if rand(4) == 3
    t = Talk.new(:slot_id => slot.id, :title => "Data protection myths and misses (privacy not security)", :speaker => "John Smith")
    t.save
  end

end