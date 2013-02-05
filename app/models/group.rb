class Group < ActiveRecord::Base

  attr_accessible :name
  
  belongs_to :user
  has_many :friends

  has_many :groups_friends
  has_many :friends, :through => :groups_friends

  validates :name, :presence => true
  validates_associated :user

  def members
    group_members = []
    group_members.tap { group_members.concat( friends ).push( self.user ) }
  end

  def set_members(friend_id_collection)
    if friend_id_collection == nil
      self.friends = []
    else
      valid_ids = clean_strings_for_ids(friend_id_collection).select do |check_id|
        self.user.friends.include?( Friend.find(check_id.to_i) )
      end
      self.friends = valid_ids.map { |id| Friend.find(id) }
    end
  end

  private

    def clean_strings_for_ids(collection)
      collection.select! { |input_id| input_id.to_i != 0 }
      collection.map { |string_id| string_id.to_i }
    end

end
