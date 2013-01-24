class Friend < ActiveRecord::Base
  attr_accessible :email, :first_name, :homecity, :last_name, :photo_prefix, :photo_suffix, :relationship, :uid

  belongs_to :user
end
