FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end
end

FactoryGirl.define do
  factory :user do
    email    { FactoryGirl.generate(:email) }
    password { "password" }  
  end  
end

FactoryGirl.define do 
  factory :email_confirmed_user, parent: :user do
    after(:create) { warn "[DEPRECATION] The :email_confirmed_user factory is deprecated, please use the :user factory instead." }
  end
end
