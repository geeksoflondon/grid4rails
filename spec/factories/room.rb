FactoryGirl.define do
  factory :room do  
    
    id          { FactoryGirl.generate(:room_id) }
    created_at  { Time.now.utc }
    updated_at  { "#{created_at}" }
      
    name          { FactoryGirl.generate(:room_name) }
    description   { "Fake description" }  
    short_code    { FactoryGirl.generate(:room_short_code) }
    capacity      { "10" }
      
  end
   
end

FactoryGirl.define do
  sequence :room_id do |n|
    "#{n}"
  end
end

FactoryGirl.define do
  sequence :room_name do |n|
    "Fake Room #{n}"
  end
end

FactoryGirl.define do
  sequence :room_short_code do |n|
    if (n < 10)
      "00#{n}"
    elsif (n < 100)
      "0#{n}"
    else
      "#{n}"
    end    
  end
end