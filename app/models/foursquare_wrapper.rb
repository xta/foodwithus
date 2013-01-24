class FoursquareWrapper

  attr_accessor :client

  def initialize(token)
    @client = Foursquare2::Client.new(:oauth_token => token)
  end

  def user_friends
    r = @client.user_friends("self", :limit => 500).items
  end

end