class Friend < ActiveRecord::Base
  # attr_accessible :email, :first_name, :homecity, :last_name, :photo_prefix, :photo_suffix, :relationship, :uid, :user_id

  belongs_to :user

  validates :uid, :presence => true

  def self.build_foursquare_friend(the_user_id, foursquare_api_friend)

    new_friend = self.new

    begin

      new_friend.email        = foursquare_api_friend.contact.email
      new_friend.first_name   = foursquare_api_friend.firstName
      new_friend.homecity     = foursquare_api_friend.homeCity
      new_friend.last_name    = foursquare_api_friend.lastName
      new_friend.photo_prefix = foursquare_api_friend.photo
# new_friend.photo_suffix = foursquare_api_friend.
      new_friend.relationship = foursquare_api_friend.relationship
      new_friend.uid          = foursquare_api_friend.id

      new_friend.user_id      = the_user_id

    rescue Exception => e
      logger.debug e
    end

    return new_friend
  end

end
