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

    top_one(profile_counter)
  end

  def nearby_food_choices(group, gps_lat, gps_lon)
    client       = FoursquareWrapper.new(group.user)
    category_ids = top_categories.map { |category| category.fsq_id }
    gps_coord    = clean_gps_for_search( gps_lat, gps_lon )

    if gps_coord

      unless top_categories.empty?
        client.search_nearby_categories(gps_coord, category_ids)
      else
        client.search_nearby_food(gps_coord)
      end

    else
      return false
    end
  end

  private

    def top_one(profile_hash)
      top_one_profiles = profile_hash.sort_by {|k,v| -v}[0...1]

      top_one_profiles.map do |key, value|
        Category.find(key)
      end
    end

    def clean_gps_for_search(lat, lon)
      gps_lat = remove_spaces(lat)
      gps_lon = remove_spaces(lon)

      if valid_float?(gps_lat) && valid_float?(gps_lon)
        "#{gps_lat},#{gps_lon}"
      else
        return false
      end
    end

    def remove_spaces(string)
      string.gsub(/\s+/, "")
    end

    def valid_float?(value)
      !!Float(value) rescue false
    end

    def clean_strings_for_ids(collection)
      collection.select! { |input_id| input_id.to_i != 0 }
      collection.map { |string_id| string_id.to_i }
    end

end
