source 'https://rubygems.org'

gem 'rails', '3.2.12'
gem 'jquery-rails'
gem 'unicorn' # Use unicorn as the app server

# database
gem 'pg'

# workers
gem 'sidekiq'

# lib task
gem 'httparty'

# foursquare
gem 'omniauth-foursquare'
gem 'foursquare2'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'

  # debugger
  gem 'pry-rails'

  # testing
  gem 'rspec-rails'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'terminal-notifier-guard'
  gem 'rb-fsevent', '~> 0.9.1'
  gem 'faker'

end

group :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails-mocha', :require => false
  gem 'webmock', '~> 1.8.0'
  gem 'vcr'
end

# deploy
gem 'capistrano'
