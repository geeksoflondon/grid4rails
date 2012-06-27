FactoryGirl.define do
  factory :talk do
    title        { "Fake talk" }
    speaker      { "Fake speaker" }
    description  { "Fake description" }
    slot         { nil }
  end 
end