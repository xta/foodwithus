class GroupsController < ApplicationController
  # GET /groups
  # GET /groups.json
  def index
    current_user ? @groups = current_user.groups : false

    respond_to :html
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @group = Group.find(params[:id])

    unless params[:lat].nil? || params[:lon].nil?
      @foursquare_results = @group.nearby_food_choices(@group, params[:lat], params[:lon])
    else
      @foursquare_results = nil
    end
  end

  # GET /groups/new
  # GET /groups/new.json
  def new
    @group = current_user.groups.build

    respond_to :html
  end

  # GET /groups/1/edit
  def edit
    @group = Group.find(params[:id])
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = current_user.groups.build(:name => params[:group][:name])
    @group.set_members(params[:member])

    if @group.save
      redirect_to root_path
    else
      render 'new'
    end

  end

  # PUT /groups/1
  # PUT /groups/1.json
  def update
    @group = Group.find(params[:id])
    @group.name = params[:group][:name]
    @group.set_members(params[:member])

    if @group.save
      redirect_to root_path
    else
      render 'edit'
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    redirect_to groups_path
  end
end
