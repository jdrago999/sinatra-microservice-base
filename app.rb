require 'bundler/setup'
require 'sinatra'
require 'sinatra/base'

# This (dotenv) has to be loaded before we load sinatra/activerecord - otherwise
# the connection info won't be available to activerecord when it's needed:
require 'dotenv'
Dotenv.load
require 'sinatra/activerecord'

require 'ruby-debug'

class Foobar < ActiveRecord::Base
end

module MyService
  class App < Sinatra::Application

    set :public_folder, Proc.new { File.join(root, "public") }

    before do
      content_type :json
    end

    after do
      ActiveRecord::Base.connection.close
    end

    post '/foobars' do
      user = Foobar.create(params)
      user.to_json
    end

    get '/foobars' do
      Foobar.all.each.map{|foobar| {id: foobar.id, name: foobar.name}}.to_json
    end

    get '/foobars/:id' do
      foobar = Foobar.find(params[:id])
      {id: foobar.id, name: foobar.name}.to_json
    end

  end
end

MyService::App.run
