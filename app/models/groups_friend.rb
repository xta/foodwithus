class GroupsFriend < ActiveRecord::Base
  
  belongs_to :group
  belongs_to :friend, :dependent => :destroy

end
