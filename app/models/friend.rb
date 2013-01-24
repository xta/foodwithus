class Friend < ActiveRecord::Base
  attr_accessible :email, :first_name, :homecity, :last_name, :photo_prefix, :photo_suffix, :relationship, :uid, :user_id

  belongs_to :user

  validates :uid, :presence => true
end
