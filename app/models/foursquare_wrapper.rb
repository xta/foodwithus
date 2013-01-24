class FoursquareWrapper

  attr_accessor :client

  def initialize(user)
    @client = Foursquare2::Client.new(:oauth_token => user.token)
  end

  def user_friends
    r = @client.user_friends("self", :limit => 500).items
  end

end