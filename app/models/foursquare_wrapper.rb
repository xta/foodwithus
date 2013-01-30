class FoursquareWrapper

  attr_accessor :client

  def initialize(user)
    @client = Foursquare2::Client.new(:oauth_token => user.token)
  end

  def user_friends
    returned_friends = @client.user_friends("self", :limit => 500).items 
    returned_friends.empty? ? false : returned_friends
  end

end