# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    uid 1
    first_name "John"
    last_name "Football"
    email "john@football.com"
    token "foursquaretoken"
  end
end
