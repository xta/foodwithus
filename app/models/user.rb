class User < ActiveRecord::Base

  has_many :friends, :dependent => :destroy
  has_many :groups, :dependent => :destroy

  has_many :user_profiles, :dependent => :destroy
  has_many :categories, :through => :user_profiles

  validates :uid, :presence => true
  validates :token, :presence => true
  validates :email, :presence => true

  def self.from_omniauth(auth)
    where(auth.slice("provider", "uid")).first || new_user_onboard(auth)
  end

  def self.new_user_onboard(auth)
    new_user = create_from_omniauth(auth)
    new_user.tap { UsersFriendsWorker.perform_async(new_user.id) if new_user }
  end

  def create_foursquare_profile(venuestats)
    begin
      venuestats.each do |stats|
        category_check = Category.find_by_fsq_id(stats.category.id)
        if category_check
          self.categories << category_check
        end
      end
    rescue Exception => e
      logger.debug e
    end
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