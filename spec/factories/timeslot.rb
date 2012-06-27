FactoryGirl.define do      
  factory :timeslot do
    
    id          { FactoryGirl.generate(:timeslot_id) }
    created_at  { Time.now.utc }
    updated_at  { "#{created_at}" }
    
    self.start  { FactoryGirl.generate(:timeslot_start) }
    self.end    { "#{self.start + 10.minutes}" }
      
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