
ENV['RACK_TEST'] = 'test'

require 'database_cleaner'
require 'webmock'
require 'bundler'
require 'debugger'
require './app'
Bundler.load

require 'api_client'

RSpec.configure do |config|
  config.include WebMock::API

  # This DatabaseCleaner strategy comes from an excellent answer here:
  # http://stackoverflow.com/a/14197798/3299764
  config.before :suite do
    DatabaseCleaner.strategy = :transaction
  end

  config.before :each do
    ApiClient.base_url = 'http://test.host/'
    stub_request(:any, /test.host/).to_rack(App)
    DatabaseCleaner.start
  end

  config.after :each do
    DatabaseCleaner.clean
  end

end