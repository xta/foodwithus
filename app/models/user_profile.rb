class UserProfile < ActiveRecord::Base
  attr_accessible :category_id, :count
  
  belongs_to :user
  belongs_to :category

end
