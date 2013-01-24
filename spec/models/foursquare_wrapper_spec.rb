require 'spec_helper'

describe FoursquareWrapper do

  before(:each) do
    user = FactoryGirl.create(:user, token: ENV['FOURSQUARE_TEST_TOKEN'])
    @client = FoursquareWrapper.new(user)
  end

  describe '.user_friends' do

    it "returns the user's friends" do
      VCR.use_cassette('user_friends') do
        friends = @client.user_friends
        friends.count.should == 2
      end
    end

  end

  describe '.user_venuestats'

  describe '.search_nearby_restaurants'

end