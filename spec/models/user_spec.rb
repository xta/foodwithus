require 'spec_helper'

describe User do

  before(:each) do
    @auth       = OmniAuth.config.mock_auth[:foursquare]
    @bad_auth   = OmniAuth.config.mock_auth[:foursquare_invalid]
  end

  describe ".from_omniauth" do

    context "for an already register user" do
      it 'finds the user in the database if already exist' do
        new_user = User.create_from_omniauth(@auth)

        lambda do
          user_from = User.from_omniauth(@auth)
          user_from.should eql(new_user)
        end.should_not change(User, :count)
      end
    end

    context "for a new user" do
      it 'creates an user' do
        lambda do
          VCR.use_cassette('from_omniauth_should_create_new_user') do
            User.from_omniauth(@auth)
          end
        end.should change(User, :count).by(1)
      end
    end

  end

  describe ".new_user_onboard" do

    context "with valid data" do 
      it "creates friends for the new_user" do
        VCR.use_cassette('new_user_onboard_friends') do
          new_user = User.new_user_onboard(@auth)
          new_user.friends.count.should == 2
        end
      end
    end

    context "with invalid data" do
      it "does not create a user" do
        new_user = User.new_user_onboard(@bad_auth)
        new_user.should == false
      end
    end

  end

  describe ".create_from_omniauth" do

    context "with a valid foursquare response" do
      it "creates a user from foursquare response" do
        new_user = User.create_from_omniauth(@auth)
        expect(new_user.uid).to eq(ENV['FOURSQUARE_TEST_UID'].to_i)
      end
    end

    context "with invalid foursquare response" do
      it 'should not create a user' do
        new_user = User.create_from_omniauth(@bad_auth)
        @auth_user.should_not eql(new_user)
      end
    end

  end

  describe '.create_self_profile' do

    before(:each) do
      VCR.use_cassette('create_self_profile') do
        @user = create(:user, token: ENV['FOURSQUARE_TEST_TOKEN'], uid: ENV['FOURSQUARE_TEST_UID'])
        client = FoursquareWrapper.new( @user )
        @self_profile = client.user_self
      end
      @user.create_self_profile(@self_profile)
    end

    it 'sets user relationship to self' do
      expect(@user.relationship).to eq("self")
    end

    it 'sets user photo' do      
      expect(@user.photo).to eq("https://foursquare.com/img/blank_boy.png")
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