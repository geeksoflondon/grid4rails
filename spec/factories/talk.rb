FactoryGirl.define do
  
  factory :talk do
    
    title        { "Fake talk" }
    speaker      { "Fake speaker" }
    description  { "Fake description" }       
    
  end  
    
  trait :scheduled do
    association :slot, :factory => :slot, :strategy => :build
    
    after(:build) do |talk|
      talk.slot.talk = talk
    end
        
  end
   
  trait :unscheduled do
    slot { nil }        
  end
  
end

FactoryGirl.define do
  sequence :talk_id do |n|
    "#{n}"
  end
end