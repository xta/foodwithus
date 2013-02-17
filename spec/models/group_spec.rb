require 'spec_helper'

describe Group do

  let(:user) {create(:user)}

  before(:each) do
    @group = user.groups.build
  end

  describe '.members' do
    before(:each) do
      friend1 = user.friends.create(:uid => 1)
      friend2 = user.friends.create(:uid => 2)
      @group.friends.push(friend1).push(friend2)
    end

    it 'returns an array of the members in group' do
      @group.members.size.should == 3
    end
  end

  describe '.set_members' do

    before(:each) do
      @friend1 = user.friends.create(:uid => 11)
      @friend2 = user.friends.create(:uid => 22)
      @friend_ids = user.friends.collect {|friend| friend.id.to_s }
    end

    it "builds a group's friends based on valid ids" do
      @group.set_members(@friend_ids)
      @group.friends.should include(@friend1)
      @group.friends.should include(@friend2)
      @group.friends.size.should == 2
    end

    it "sanitizes/ignores any invalid friend ids given" do
      other_user = FactoryGirl.create(:user)
      invalid_friend = other_user.friends.create(:uid => 500)
      @friend_ids.concat( [invalid_friend.id.to_s, "as"] )

      @group.set_members(@friend_ids)
      @group.friends.should_not include(invalid_friend)
    end

    it "sets group's friends count to zero if no friend ids passed in" do
      @group.set_members(nil)
      @group.friends.size.should == 0
    end

  end

  describe '.top_categories' do

    before :each do
      group           = FactoryGirl.create(:group)
      @top_categories = group.top_categories
    end

    it "should get top 3 most visited categories by group" do
      @top_categories.first.short_name.should == "Asian"
    end

    it "shouldnt return more than 3 results" do
      @top_categories.size.should == 3
    end

  end

end
