require 'spec_helper'

describe User do

    let(:auth) do
      OmniAuth::AuthHash.new({  
        :provider => 'foursquare',
        :uid => '12345678',
        :info => {        :email => "foo@bar.com",
                          :first_name => "Foobaz",
                          :last_name => "Bazbar",
                          :location => "New York"
                  },
        :credentials => {
                          :token => "tokengoeshere"
                  }
      })
    end

    let(:bad_auth) do
      OmniAuth::AuthHash.new({
        :not_valid => 'no_valid_data_here'
      })
    end

    let(:user) { User.find_by_uid('12345678') }

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
        User.from_omniauth(auth)
      end.should change(User, :count).by(1)

    end

  end

  describe ".new_user_onboard" do

    it "creates friends for the new_user"

    it "does not create friends for an invalid user"

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

end