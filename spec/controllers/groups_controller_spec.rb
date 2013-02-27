require 'spec_helper'

describe GroupsController do

  before(:each) do
    user = create(:user)
    session[:user_id] = user.id
  end

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

    it "assigns a new group" do
      get :new
      assigns(:group).should be_a_new(Group)
    end

    it "renders the :new template" do
      get :new
      response.should render_template :new
    end

  end

  describe 'GET #edit' do


    it "assigns the requested group" do
      group = create(:group)
      get :edit, id: group
      assigns(:group).should eq group
    end

    it "renders the :edit template" do
      group = create(:group)
      get :edit, id: group
      response.should render_template :edit
    end
  end

  describe 'POST #create' do

    context "with valid attributes" do
      it "saves the new group in the database" do
        expect{
          post :create, group: attributes_for(:group)
        }.to change(Group, :count).by(1)
      end

      it "redirects to the home page" do
        post :create, group: attributes_for(:group)
        response.should redirect_to root_url
      end
    end

    context "with invalid attributes" do
      it "does not save the new group in the database" do
        expect{
          post :create,
          group: attributes_for(:invalid_group)
        }.to_not change(Group, :count)
      end

      it "re-renders the :new template" do
        post :create,
          group: attributes_for(:invalid_group)
        response.should render_template :new
      end
    end

  end

  describe 'PUT #update' do

    before :each do
      @group = create(:group, name: "Fast Food")
    end

    it "locates the requested @group" do
      put :update, id: @group, group: attributes_for(:group)
      assigns(:group).should eq(@group)
    end

    context "valid attributes" do
      it "changes @group's attributes" do
        put :update, id: @group,
          group: attributes_for(:group, name: "Fine Dining")
        @group.reload
        @group.name.should eq("Fine Dining")
      end

      it "redirects to the updated group" do
        put :update, id: @group, group: attributes_for(:group)
        response.should redirect_to root_path
      end
    end

    context "invalid attributes" do
      it "does not change @group's attributes" do
        put :update, id: @group, :group => {name: nil}
        @group.reload
        @group.name.should_not eq(nil)
      end

      it "re-renders the edit method" do
        put :update, id: @group, :group => {name: nil}
        response.should render_template :edit
      end
    end

  end

  describe 'DELETE #destroy' do

    before :each do
      @group = create(:group)
    end

    it "deletes the group" do
      expect{
        delete :destroy, id: @group
      }.to change(Group,:count).by(-1)
    end

    it "redirects to groups#index" do
      delete :destroy, id: @group
      response.should redirect_to groups_url
    end

  end


end