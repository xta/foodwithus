require 'spec_helper'

describe FoursquareWrapper do

  before(:each) do
    @user = FactoryGirl.create(:user, token: ENV['FOURSQUARE_TEST_TOKEN'], uid: ENV['FOURSQUARE_TEST_UID'])
    @client = FoursquareWrapper.new(@user)

    blank_user = FactoryGirl.create(:user, token: ENV['FOURSQUARE_TEST_TOKEN_BLANK_USER'])
    @blank_client = FoursquareWrapper.new(blank_user)
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
        venuestats = @client.venuestats(@user)
        venuestats.venues.size.should == 5
        venuestats.categories.size.should == 10
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

  describe '.search_nearby_restaurants' do
    # https://developer.foursquare.com/docs/venues/search

    xit 'takes gps and food categories to return nearby restaurants' do
    end

  end

  describe '.search_nearby_food' do
    # https://developer.foursquare.com/docs/venues/explore

    xit 'takes gps and returns default food nearby' do
    end

  end

end