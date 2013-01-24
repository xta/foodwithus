require 'spec_helper'

describe Friend do

  describe '#build_foursquare_friend' do

    before(:each) do
      @user = FactoryGirl.create(:user, token: ENV['FOURSQUARE_TEST_TOKEN'])
      client = FoursquareWrapper.new(@user)

      VCR.use_cassette('build_foursquare_friend') do
        @foursquare_api_friend = client.user_friends.first
      end
    end

    it 'builds a Friend from a foursquare_api friend' do
      new_friend = Friend.build_foursquare_friend(@user.id, @foursquare_api_friend)

      new_friend.instance_of?(Friend).should eql(true)
      new_friend.first_name.should eql("Tim")
    end

  end
  

end
