class FoursquareWrapper

  attr_accessor :client

  def initialize(user)
    @client = Foursquare2::Client.new(:oauth_token => user.token)
  end

  def user_friends
    returned_friends = @client.user_friends("self", :limit => 500).items 
    returned_friends.empty? ? false : returned_friends
  end

  def venuestats(foursquare_user)
    @client.venuestats(foursquare_user.uid)
  end

  def venue_categories
    @client.venue_categories
  end

  def search_nearby_categories(ll, categories)
    csv_categories = array_to_csv(categories)
    response = @client.search_venues(:ll => ll, :intent => "browse", :radius => 4000, :categoryId => csv_categories)
    response.groups.first.items
  end

  def search_nearby_food(ll)
    response = @client.explore_venues(:ll => ll, :section => 'food')
    response.groups.first.items
  end

  private

    def array_to_csv(array)
      array.join(',')
    end

end