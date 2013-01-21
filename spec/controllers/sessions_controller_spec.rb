require 'spec_helper'

describe SessionsController do

  describe '#create' do

    xit 'sets the current user if valid' do

      # mock that valid
        # user = FactoryGirl.build(:user)
      # post :create
      # should redirect to root
    end

    xit 'does not set the current user if not valid login' do

      # mock that invalid
      # post :create
      # should redirect to root with notice
    end

  end

  describe '#destroy' do

    it 'destroys the current user session'

  end

end
