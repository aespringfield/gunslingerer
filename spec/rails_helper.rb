ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'active_support/testing/time_helpers'
require 'spec_helper'
require 'capybara/rails'
require 'capybara/rspec'
require 'webmock/rspec'

Dir[File.expand_path('../support/*.rb', __FILE__)].each { |path| require path }
Dir[File.expand_path('../factories/*.rb', __FILE__)].each { |path| require path }

ActiveRecord::Migration.maintain_test_schema!
Capybara.default_driver = :selenium_chrome_headless
WebMock.allow_net_connect!

RSpec.configure do |config|
    config.include Rails.application.routes.url_helpers
    config.include FactoryBot::Syntax::Methods
    config.include ActiveSupport::Testing::TimeHelpers
    config.include FeatureSpecHelper
    
    config.before(:each) do
        Rails.cache.clear
        DatabaseCleaner.clean_with(:truncation)
    end

    config.before(:each, type: feature) do
        Capybara.reset_sessions!
    end
    
    config.after(:each) do
        DatabaseCleaner.clean
    end
end