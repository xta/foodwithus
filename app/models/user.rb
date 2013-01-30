class User < ActiveRecord::Base

  has_many :friends

  validates :uid, :presence => true
  validates :token, :presence => true
  validates :email, :presence => true

  def self.from_omniauth(auth)
    where(auth.slice("provider", "uid")).first || new_user_onboard(auth)
  end

  def self.new_user_onboard(auth)
    new_user = create_from_omniauth(auth)

    if new_user
      client = FoursquareWrapper.new(new_user)
      friends = client.user_friends

      if friends
        friends.each do |friend|
          begin
            new_friend = Friend.build_foursquare_friend(new_user.id, friend)
            new_friend.save
          rescue Exception => e
            logger.debug e
          end
        end
      end

    end

    return new_user
  end

  private

    def self.create_from_omniauth(auth)

      begin
        user = self.new

        user.provider    = auth["provider"]
        user.uid         = auth["uid"]
        user.first_name  = auth["info"]["first_name"]
        user.last_name   = auth["info"]["last_name"]
        user.token       = auth["credentials"]["token"]
        user.email       = auth["info"]["email"]
        user.location    = auth["info"]["location"]

        user.tap { user.save }
      rescue
        return false
      end

    end

end