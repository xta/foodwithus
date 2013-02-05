class FriendProfile < ActiveRecord::Base
  
  belongs_to :friend
  belongs_to :category

end
