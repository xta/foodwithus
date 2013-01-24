# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :friend do
    uid 1
    first_name "MyString"
    last_name "MyString"
    relationship "MyString"
    photo_prefix "MyString"
    photo_suffix "MyString"
    email "MyString"
    homecity "MyString"
  end
end
