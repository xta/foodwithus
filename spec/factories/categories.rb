FactoryGirl.define do

  factory :category do

    factory :asian do
      fsq_id '4bf58dd8d48988d142941735'
      name 'Asian Restaurant'
      plural_name 'Asian Restaurants'
      short_name 'Asian'
    end

    factory :chinese do
      fsq_id '4bf58dd8d48988d145941735'
      name 'Chinese Restaurant'
      plural_name 'Chinese Restaurants'
      short_name 'Chinese'
    end

    factory :cupcake do
      fsq_id '4bf58dd8d48988d1bc941735'
      name 'Cupcake Shop'
      plural_name 'Cupcake Shops'
      short_name 'Cupcakes'
    end

    factory :diner do
      fsq_id '4bf58dd8d48988d147941735'
      name 'Diner'
      plural_name 'Diners'
      short_name 'Diner'
    end

    factory :falafel do
      fsq_id '4bf58dd8d48988d10b941735'
      name 'Falafel Restaurant'
      plural_name 'Falafel Restaurants'
      short_name 'Falafel'
    end

    factory :pizza do
      fsq_id '4bf58dd8d48988d1ca941735'
      name 'Pizza Place'
      plural_name 'Pizza Places'
      short_name 'Pizza'
    end

    factory :taco do
      fsq_id '4bf58dd8d48988d151941735'
      name 'Taco Place'
      plural_name 'Taco Places'
      short_name 'Taco'
    end

  end
end