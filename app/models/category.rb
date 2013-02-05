class Category < ActiveRecord::Base
  # attr_accessible :fsq_id, :name, :plural_name, :short_name

  has_many :friend_profiles
  has_many :friends, :through => :friend_profiles

end
