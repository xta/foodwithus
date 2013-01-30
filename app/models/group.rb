class Group < ActiveRecord::Base
  
  belongs_to :user
  has_many :friends

  def members
    user.friends.collect {|friend| friend.id}
  end

end
