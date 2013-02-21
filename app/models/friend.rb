class Friend < ActiveRecord::Base
  attr_accessible :uid

  belongs_to :user

  has_many :groups_friends
  has_many :groups, :through => :groups_friends

  has_many :friend_profiles, :dependent => :destroy
  has_many :categories, :through => :friend_profiles

  validates :uid, :presence => true
  validates_associated :user

  def self.create_all_from_foursquare(user_id, foursquare_friends)
    if foursquare_friends

      foursquare_friends.each do |friend|
        begin
          unless friend.type == "page"
            new_friend = build_foursquare_friend(user_id, friend)
            new_friend.save
          end
        rescue Exception => e
          logger.debug e
        end
      end

    else
      return false
    end
  end

  def create_foursquare_profile(venuestats)
    begin
      venuestats.each do |stats|
        category_check = Category.find_by_fsq_id(stats.category.id)
        if category_check
          begin
            friend_profiles.create(:category_id => category_check.id, :count => stats.venueCount)
          rescue Exception => e
            logger.debug e
          end
        end
      end
    rescue Exception => e
      logger.debug e
    end
  end

  private

    def self.build_foursquare_friend(the_user_id, foursquare_api_friend)
      new_friend = self.new

      begin
        new_friend.email        = foursquare_api_friend.contact.email
        new_friend.first_name   = foursquare_api_friend.firstName
        new_friend.homecity     = foursquare_api_friend.homeCity
        new_friend.last_name    = foursquare_api_friend.lastName
        new_friend.photo        = foursquare_api_friend.photo
        new_friend.relationship = foursquare_api_friend.relationship
        new_friend.uid          = foursquare_api_friend.id
        new_friend.user_id      = the_user_id
      rescue Exception => e
        logger.debug e
      end

      return new_friend
    end

end
