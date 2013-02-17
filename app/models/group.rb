class Group < ActiveRecord::Base

  attr_accessible :name
  
  belongs_to :user

  has_many :groups_friends, :dependent => :destroy
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

  def top_categories
    profile_counter = {}
    members.each do |member|
      member.instance_of?(User) ? profiles = member.user_profiles : profiles = member.friend_profiles

      unless profiles.empty?
        profiles.each do |profile|
          unless profile.count.nil?
            if profile_counter.has_key?(profile.category_id)
              profile_counter[profile.category_id] += 1
            else
              profile_counter[profile.category_id] = 1
            end
          end
        end
      end
    end

    top_three(profile_counter)
  end

  private

    def top_three(profile_hash)
      top_three_profiles = profile_hash.sort_by {|k,v| -v}[0...3]

      top_three_profiles.map do |key, value|
        Category.find(key)
      end
    end

    def clean_strings_for_ids(collection)
      collection.select! { |input_id| input_id.to_i != 0 }
      collection.map { |string_id| string_id.to_i }
    end

end
