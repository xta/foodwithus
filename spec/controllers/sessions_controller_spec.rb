require 'spec_helper'

describe SessionsController do

  describe '.new' do
    
    before :each do 
      get :new
    end
    it { should redirect_to('/auth/foursquare') }

  end


  describe '.create' do

    before :each do
      @user = FactoryGirl.create(:user)
    end

    it 'sets the user_id in session with valid user' do
      User.stubs(:from_omniauth).returns(@user)
      get :create, :provider => "foursquare"
      
      session[:user_id].should == @user.id
    end

    it 'should not set the user_id in session without a valid user' do
      User.stubs(:from_omniauth).returns(nil)
      get :create, :provider => "foursquare"
      
      session[:user_id].should == nil
    end

  end


  describe '.destroy' do

    before :each do
      session[:user_id] = 1
      get :destroy
    end

    it { session[:user_id].should == nil }
    it { flash[:notice].should == "Signed out!" }
    it { should redirect_to(root_path) }

  end


  describe '.failure' do
    before :each do
      get :failure
    end

    it { session[:user_id].should == nil }
    it { flash[:notice].should == "An error has occurred. Please try again." }
    it { should redirect_to(root_path) }

  end

end
