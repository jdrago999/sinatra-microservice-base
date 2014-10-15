require "rspec/core/rake_task"
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require './app'
require 'sinatra/activerecord/rake'


RSpec::Core::RakeTask.new
require 'dotenv/tasks'
task :console => :dotenv do
  require 'irb'
  require 'irb/completion'
  require 'pry'
  ARGV.clear
  IRB.start
end
