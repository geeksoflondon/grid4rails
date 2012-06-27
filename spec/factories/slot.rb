FactoryGirl.define do
  factory :slot do    
    
    id          { FactoryGirl.generate(:slot_id) }
    created_at  { Time.now.utc }
    updated_at  { "#{created_at}" }
              
    association :room, :factory => :room, :strategy => :build
    association :timeslot, :factory => :timeslot, :strategy => :build
    talk        { nil }
    locked      { false }
    
  end 
end

FactoryGirl.define do
  sequence :slot_id do |n|
    "#{n}"
  end
end