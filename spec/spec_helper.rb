# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'rspec/rails/mocha'
require 'webmock/rspec'
require 'vcr'
require 'sidekiq/testing/inline'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  config.include FactoryGirl::Syntax::Methods

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
  # c.default_cassette_options = { :record => :new_episodes, :erb => true }
  c.filter_sensitive_data("<TEST_TOKEN>") { ENV['FOURSQUARE_TEST_TOKEN'] }
  c.filter_sensitive_data("<TEST_TOKEN>") { ENV['FOURSQUARE_TEST_TOKEN_BLANK_USER'] }
end

OmniAuth.config.test_mode = true
OmniAuth.config.mock_auth[:foursquare] = OmniAuth::AuthHash.new({
  :provider     => 'foursquare',
  :uid          => ENV['FOURSQUARE_TEST_UID'],
  :info         => {  :email      => "foo@bar.com",
                      :first_name => "Foobaz",
                      :last_name  => "Bazbar",
                      :location   => "New York"
                    },
  :credentials  => {
                      :token      => ENV['FOURSQUARE_TEST_TOKEN']
                    }
  })

OmniAuth.config.mock_auth[:foursquare_invalid] = OmniAuth::AuthHash.new({
  :not_valid => 'no_valid_data_here'
})
