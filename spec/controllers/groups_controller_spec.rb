require 'spec_helper'

describe GroupsController do

  describe 'GET #index' do
    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end

  describe 'GET #show' do

    it "assigns the requested group to @group" do
      group = create(:group)
      get :show, id: group
      assigns(:group).should eq group
    end

    it "renders the :show template" do
      group = create(:group)
      get :show, id: group
      response.should render_template :show
    end

  end

  describe 'GET #new' do

  end

  describe 'GET #edit' do

  end

  describe 'POST #create' do

  end

  describe 'PUT #update' do

  end

  describe 'DELETE #destroy' do

  end


end