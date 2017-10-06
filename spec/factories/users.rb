FactoryGirl.define do
  factory :user do
    full_name 'John Doe'
    sequence(:username) { |n| "user#{n}" }
    role 0
    password 'password'
  end
end
