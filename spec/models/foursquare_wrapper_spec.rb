require 'spec_helper'

describe FoursquareWrapper do

  before(:each) do
    user = FactoryGirl.create(:user, token: ENV['FOURSQUARE_TEST_TOKEN'])
    @client = FoursquareWrapper.new(user)

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
      VCR.use_cassette('user_friends_with_no_friends') do
        friends = @blank_client.user_friends
        friends.should == false
      end
    end

  end

  describe '.user_venuestats'

  describe '.search_nearby_restaurants'

end