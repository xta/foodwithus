require 'spec_helper'

describe Group do

  let(:user) {create(:user)}

  before(:each) do
    group = user.groups.build
  end

  describe '.members' do

    it 'returns an array of user friends friend_ids' do
      friend1 = user.friends.create(:uid => 11)
      friend2 = user.friends.create(:uid => 22)
      friend_ids = user.friends.collect {|friend| friend.id}

      user.groups.first.members.should == friend_ids
    end

    it 'should return no results if user has no friends' do
      friend_ids = user.friends.collect {|friend| friend.id}

      user.groups.first.members.should == []
    end

  end

end