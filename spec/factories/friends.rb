# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :friend do

    uid 1
    first_name "MyString"
    last_name "MyString"
    relationship "MyString"
    photo "MyString"
    email "MyString"
    homecity "MyString"

    factory :asian_food_friend do
      uid 2

      after(:create) do |friend|
        asian   = FactoryGirl.create(:asian)
        chinese = FactoryGirl.create(:chinese)

        [asian, chinese].each do |category|
          new_profile = friend.friend_profiles.new
          new_profile.count = 5
          new_profile.category = category
          new_profile.save
        end
      end
    end

    factory :misc_food_friend do
      uid 3

      after(:create) do |friend|
        cupcake   = FactoryGirl.create(:cupcake)
        pizza     = FactoryGirl.create(:pizza)

        [cupcake, pizza].each do |category|
          new_profile = friend.friend_profiles.new
          new_profile.count = 2
          new_profile.category = category
          new_profile.save
        end
      end
    end

    factory :empty_friend_1 do
      uid 4
    end

    factory :empty_friend_2 do
      uid 5
    end

  end

end
