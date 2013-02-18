# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :user do
    uid 1
    first_name "John"
    last_name "Football"
    email "john@football.com"
    token "foursquaretoken"

    factory :groups_user do
      uid 200
      first_name "Tom"
      last_name "Johnson"
      email "johnson@football.com"
      token ENV['FOURSQUARE_TEST_TOKEN']

      after(:create) do |user|
        diner   = FactoryGirl.create(:diner)
        falafel = FactoryGirl.create(:falafel)

        [diner, falafel].each do |category|
          new_profile = user.user_profiles.new
          new_profile.count = 6
          new_profile.category_id = category.id
          new_profile.save
        end
      end
    end

    factory :empty_user do
      first_name "M T"
      last_name "User"
      email "mt@football.com"
      token ENV['FOURSQUARE_TEST_TOKEN_BLANK_USER']
    end

  end

end
