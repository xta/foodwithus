#FoodWithUs

We help you decide where to eat nearby with friends. [Log in](http://foodwith.us/) and find nearby restaurants based on your friends' check-in histories.

Created at the [2013 Foursquare Hackathon](https://www.hackerleague.org/hackathons/foursquare-hackathon-2013). Featured in [About Foursquare's Best of the 2013 Foursquare Hackathon](http://aboutfoursquare.com/best-of-the-2013-foursquare-hackathon/).

#Live Site

[foodwith.us](http://foodwith.us/)

# Setup
    git clone git@github.com:xta/foodwithus.git
    cd foodwithus
    bundle
* create a `/config/database.yml` for postgresql setup
* create a `/config/initializers/omniauth.rb` with Foursquare API keys

# Start localhost
    redis-server /usr/local/etc/redis.conf
    bundle exec sidekiq
    rails s

# Testing
* create a `/config/test_settings.yml` with a sample user's Foursquare token

    bundle exec guard

# Etc

[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/xta/foodwithus) 