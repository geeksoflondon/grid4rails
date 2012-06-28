FactoryGirl.define do
  factory :slot do    
    
    association :room, :factory => :room, :strategy => :build
    association :timeslot, :factory => :timeslot, :strategy => :build         
    
  end
  
  trait :occupied do
    association :talk, :factory => :talk, :strategy => :build
    
    after(:build) do |slot|
      slot.talk.slot = slot
    end
    
  end
  
  trait :unoccupied do 
    talk      { nil }
  end
  
  trait :locked do
    locked      { true }
  end
  
  trait :unlocked do
    locked      { false }
  end
  
end

FactoryGirl.define do
  sequence :slot_id do |n|
    "#{n}"
  end
end