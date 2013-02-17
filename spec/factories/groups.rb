FactoryGirl.define do
  factory :group do

    name 'taco truck trio'
    user_id 1

    after(:create) do |group|
      group.user     = FactoryGirl.create(:groups_user)
      group.friends << FactoryGirl.create(:asian_food_friend)
      group.friends << FactoryGirl.create(:misc_food_friend)
    end

  end
end
