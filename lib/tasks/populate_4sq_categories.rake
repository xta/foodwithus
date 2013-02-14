require 'httparty'

desc "populate categories"
task :populate_categories => [:environment] do

  # WebMock.allow_net_connect!

  url = "https://api.foursquare.com/v2/venues/categories?client_id=#{ENV['DEV_CLIENT_ID']}&client_secret=#{ENV['DEV_CLIENT_SECRET']}&v=20130204"
  response = HTTParty.get(url)

  response["response"]["categories"][2]["categories"].each do |category|

    begin

      puts category["name"]

      new_category = Category.new      
      new_category.fsq_id       = category["id"]
      new_category.name         = category["name"]
      new_category.plural_name  = category["pluralName"]
      new_category.short_name   = category["shortName"]
      new_category.save

    rescue Exception => e
      logger.debug e
    end

  end

end
