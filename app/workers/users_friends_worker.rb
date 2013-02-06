class UsersFriendsWorker
  include Sidekiq::Worker

  def perform(user_id)
    user    = User.find_by_id(user_id)
    client  = FoursquareWrapper.new(user)
    friends = client.user_friends
    Friend.create_all_from_foursquare(user_id, friends)

    UsersProfilesWorker.perform_async(user_id)
  end

end