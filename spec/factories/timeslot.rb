FactoryGirl.define do    
    
  factory :timeslot do
    
    self.name             { FactoryGirl.generate(:timeslot_name) }
    self.start            { FactoryGirl.generate(:timeslot_start) }
    self.end              { "#{self.start + 10.minutes}" }
    self.assign_slots     { true }
    self.description      { FactoryGirl.generate(:timeslot_description) }
    self.global_talk_id   { nil }  
      
  end    
  
end

FactoryGirl.define do
  sequence :timeslot_id do |n|
    "#{n}"
  end
end

FactoryGirl.define do
  sequence :timeslot_start do |n|   
    begin
      Time.parse(n)
    rescue TypeError
      n = Time.now.utc
    end
    n + 10.minutes
  end
end

FactoryGirl.define do
  sequence :timeslot_name do |n|
    "Fake Timeslot #{n}"
  end
end

FactoryGirl.define do
  sequence :timeslot_description do |n|
    "Fake timeslot description #{n}"
  end
end