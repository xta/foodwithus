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
      other_user = create(:user)
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
      group           = create(:default_group)
      @top_categories = group.top_categories
    end

    it "should get most visited categories for group" do
      @top_categories.first.short_name.should == "Asian"
      @top_categories.size.should == 3
    end

  end

  describe '.nearby_food_choices' do

    it 'returns restaurant choices for group based on group profiles' do
      VCR.use_cassette('nearby_food_choices_with_profile', :match_requests_on => [:method]) do
        group       = create(:default_group)
        nearby_food = group.nearby_food_choices(group,"40.7523921","-73.9227625")

        nearby_food.first.name.should == "Tito Rad's"
        nearby_food.first.contact.formattedPhone.should == "(718) 205-7299"
        nearby_food.first.location.address.should == "49-12 Queens Blvd."
        nearby_food.first.location.city.should == "New York"
        nearby_food.first.location.state.should == "NY"
        nearby_food.first.location.cc.should == "US"
        nearby_food.first.location.postalCode.should == "11377"
      end
    end

    it 'returns food choices nearby if no group profiles' do
      VCR.use_cassette('nearby_food_choices_profileless', :match_requests_on => [:method]) do
        empty_group = create(:empty_group)
        empty_food = empty_group.nearby_food_choices(empty_group,"40.7523921","-73.9227625")

        empty_food.first.name.should == "Savory Cafe"
        empty_food.first.contact.formattedPhone.should == "(718) 361-7800"
        empty_food.first.location.address.should == "3602 36th Avenue"
        empty_food.first.location.city.should == "Long Island City"
        empty_food.first.location.state.should == "NY"
        empty_food.first.location.cc.should == "US"
        empty_food.first.location.postalCode.should == "11106"
      end
    end


  end

end
