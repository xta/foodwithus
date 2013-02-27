FactoryGirl.define do
  factory :group do

    name 'grub seekers'
    user_id 1

    factory :default_group do

      name 'taco truck trio'
      user_id 2

      after(:create) do |group|
        group.user     = FactoryGirl.create(:groups_user)
        group.friends << FactoryGirl.create(:asian_food_friend)
        group.friends << FactoryGirl.create(:misc_food_friend)
      end
    end

    factory :empty_group do
      name 'empty peoples club'

      after(:create) do |group|
        group.user     = FactoryGirl.create(:empty_user)
        group.friends << FactoryGirl.create(:empty_friend_1)
        group.friends << FactoryGirl.create(:empty_friend_2)
      end
    end

    factory :invalid_group do
      name nil
    end

  end
end
