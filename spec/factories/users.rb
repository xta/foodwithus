# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    uid 1
    first_name "MyString"
    last_name "MyString"
    email "MyString"
    token "MyString"
  end
end
