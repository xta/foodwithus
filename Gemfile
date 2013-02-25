source 'https://rubygems.org'

gem 'rails', '3.2.12'
gem 'jquery-rails'
gem 'unicorn' # server

# database
gem 'pg'

# workers
gem 'sidekiq'

# lib task
gem 'httparty'

# foursquare
gem 'omniauth-foursquare'
gem 'foursquare2'

# deploy
gem 'capistrano'

group :assets do
  gem 'uglifier', '>= 1.0.3'

  # debugger
  gem 'pry-rails'

  # testing
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'guard-rspec'
  gem 'terminal-notifier-guard'
  gem 'rb-fsevent', '~> 0.9.1'
end

group :test do
  gem "database_cleaner"
  gem 'faker'
  gem 'capybara'
  gem 'rspec-rails-mocha', :require => false
  gem 'webmock', '~> 1.8.0'
  gem 'vcr'
end
