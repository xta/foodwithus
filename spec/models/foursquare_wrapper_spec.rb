require 'spec_helper'

describe FoursquareWrapper do

  before(:each) do
    @user = FactoryGirl.create(:user, token: ENV['FOURSQUARE_TEST_TOKEN'], uid: ENV['FOURSQUARE_TEST_UID'])
    @client = FoursquareWrapper.new(@user)

    blank_user = FactoryGirl.create(:user, token: ENV['FOURSQUARE_TEST_TOKEN_BLANK_USER'])
    @blank_client = FoursquareWrapper.new(blank_user)
  end

  describe '.user_self' do
    xit "returns the user's friends" do
      VCR.use_cassette('users_self') do
        user_self = @client.users_self
        user_self.relationship.should == "self"
      end
    end    
  end

  describe '.user_friends' do

    it "returns the user's friends" do
      VCR.use_cassette('user_friends') do
        friends = @client.user_friends
        friends.count.should == 2
      end
    end

    it 'returns false if user has not friends' do
      VCR.use_cassette('user_friends_with_no_friends', :match_requests_on => [:method]) do
        friends = @blank_client.user_friends
        friends.should == false
      end
    end

  end

  describe '.user_venuestats' do

    it 'returns venuestats for given person with uid attribute' do
      VCR.use_cassette('user_venuestats_self') do
        venuestats_categories = @client.venuestats(@user)
        venuestats_categories.size.should == 10
        venuestats_categories.first.venueCount.should == 4
      end
    end

  end

  describe '.venue_categories' do

    it 'gets the list of all categories from foursquare' do
      VCR.use_cassette('venue_categories_list') do
        categories = @client.venue_categories
        categories.size.should == 9
      end
    end

  end

  describe '.search_nearby_categories' do
    # https://developer.foursquare.com/docs/venues/search

    it 'returns nearby restaurants from gps and categories' do
      VCR.use_cassette('search_nearby_categories') do
        categories = ['4bf58dd8d48988d1d2941735', '4bf58dd8d48988d151941735', '4bf58dd8d48988d149941735']
        nearby_categories = @client.search_nearby_categories('40.7,-74', categories)

        nearby_categories.first.name.should == "La Esquina"
        nearby_categories.size.should == 30
      end
    end

  end

  describe '.search_nearby_food' do
    # https://developer.foursquare.com/docs/venues/explore

    it 'returns food nearby from gps' do
      VCR.use_cassette('search_nearby_food') do
        nearby_food = @client.search_nearby_food('40.7,-74')
        nearby_food.first.venue.name.should == "Happy Days Diner"
        nearby_food.size.should == 30
      end
    end

  end

end
