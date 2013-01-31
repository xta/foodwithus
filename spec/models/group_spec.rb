require 'spec_helper'

describe Group do

  let(:user) {create(:user)}

  before(:each) do
    @group = user.groups.build
  end

  describe '.members' do

    it 'returns an array of user friends friend_ids' do
      friend1 = user.friends.create(:uid => 11)
      friend2 = user.friends.create(:uid => 22)
      friend_ids = user.friends.collect {|friend| friend.id}

      @group.members.should == friend_ids
    end

    it 'should return no results if user has no friends' do
      friend_ids = user.friends.collect {|friend| friend.id}

      @group.members.should == []
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

end
