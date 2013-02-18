require 'spec_helper'

describe User do

    let(:auth) do
      OmniAuth::AuthHash.new({  
        :provider => 'foursquare',
        :uid => ENV['FOURSQUARE_TEST_UID'],
        :info => {        :email => "foo@bar.com",
                          :first_name => "Foobaz",
                          :last_name => "Bazbar",
                          :location => "New York"
                  },
        :credentials => {
                          :token => ENV['FOURSQUARE_TEST_TOKEN']
                  }
      })
    end

    let(:bad_auth) do
      OmniAuth::AuthHash.new({
        :not_valid => 'no_valid_data_here'
      })
    end

    let(:user) { User.find_by_uid(ENV['FOURSQUARE_TEST_UID']) }

  describe ".from_omniauth" do

    it 'finds the user in the database if already exist' do
      new_user = User.create_from_omniauth(auth)

      lambda do
        user_from = User.from_omniauth(auth)
        user_from.should eql(new_user)
      end.should_not change(User, :count)
    end

    it 'triggers create_from_omniauth if user does not exist' do

      lambda do
        VCR.use_cassette('from_omniauth_should_create_new_user') do
          User.from_omniauth(auth)
        end
      end.should change(User, :count).by(1)

    end

  end

  describe ".new_user_onboard" do

    it "creates friends for the new_user" do
      VCR.use_cassette('new_user_onboard_friends') do
        new_user = User.new_user_onboard(auth)
        new_user.friends.count.should == 2
      end
    end

    it "does not create a user with invalid data given" do
        new_user = User.new_user_onboard(bad_auth)
        new_user.should == false
    end

  end

  describe ".create_from_omniauth" do

    it "creates a user from foursquare response" do
      new_user = User.create_from_omniauth(auth)
      user.should eql(new_user)
    end

    it 'should not create a user if invalid foursquare response' do
      new_user = User.create_from_omniauth(bad_auth)
      user.should_not eql(new_user)
    end

  end

# test needs to be refactored to not depend on the database Category seed
  # describe '.create_foursquare_profile' do
  #   before(:each) do
  #     VCR.use_cassette('build_foursquare_user_profile') do
  #       @user = FactoryGirl.create(:user, token: ENV['FOURSQUARE_TEST_TOKEN'], uid: ENV['FOURSQUARE_TEST_UID'])
  #       client = FoursquareWrapper.new( @user )
  #       @foursquare_venuestats = client.venuestats( @user )
  #     end
  #   end

  #   it 'sets profile of food types for user' do
  #     @user.create_foursquare_profile(@foursquare_venuestats)

  #     @user.categories.size.should == 9
  #     @user.user_profiles.first.count.should == 4
  #   end

  # end

end