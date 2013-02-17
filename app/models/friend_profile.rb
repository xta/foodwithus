class FriendProfile < ActiveRecord::Base
  attr_accessible :category_id, :count
  
  belongs_to :friend
  belongs_to :category

  validates :category_id, :presence => true
  validates :count, :presence => true

end
