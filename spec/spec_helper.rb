
ENV['RACK_ENV'] = 'test'
require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'database_cleaner'
require 'webmock'
require 'bundler'
require 'factory_girl'
require 'faker'
require 'pry'
require './app'

ActiveRecord::Base.logger = nil
Bundler.load

require 'my_service'

silence_stream STDOUT do
  load "./db/schema.rb"
end

RSpec.configure do |config|
  config.include WebMock::API

  Dir["./spec/factories/**.rb"].each {|f| require f}

  # This DatabaseCleaner strategy comes from an excellent answer here:
  # http://stackoverflow.com/a/14197798/3299764
  config.before :suite do
    DatabaseCleaner.strategy = :transaction
  end

  config.after :suite do
    WebMock.disable!
  end

  config.before :each do
    MyService.base_url = 'http://test.host/'
    stub_request(:any, /test.host/).to_rack(MyService::App)
    DatabaseCleaner.start
  end

  config.after :each do
    DatabaseCleaner.clean
  end

end
