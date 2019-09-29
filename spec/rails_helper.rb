ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'spec_helper'
require 'capybara/rails'
require 'capybara/rspec'
require 'webmock/rspec'

Dir[File.expand_path('../support/*.rb', __FILE__)].each { |path| require path }
Dir[File.expand_path('../factories/*.rb', __FILE__)].each { |path| require path }

Capybara.default_driver = :selenium_chrome_headless
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
    config.include Rails.application.routes.url_helpers
    config.include FactoryBot::Syntax::Methods
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