class UsersProfilesWorker
  include Sidekiq::Worker

  def perform(user_id)

    user    = User.find_by_id(user_id)
    client  = FoursquareWrapper.new(user)
    friends = user.friends

    # for user self
    user_stats = client.venuestats(user)
    user.create_foursquare_profile(user_stats)

    # for friends
    unless friends.empty?
      friends.each do |friend|
        friend_stats = client.venuestats(friend)
        friend.create_foursquare_profile(friend_stats)
      end
    end
    
  end

end