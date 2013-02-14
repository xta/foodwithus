class FriendProfile < ActiveRecord::Base
  attr_accessible :category_id, :count
  
  belongs_to :friend
  belongs_to :category

end
