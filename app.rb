require 'bundler/setup'
require 'sinatra'
require 'sinatra/base'

# This (dotenv) has to be loaded before we load sinatra/activerecord - otherwise
# the connection info won't be available to activerecord when it's needed:
require 'dotenv'
Dotenv.load
require 'sinatra/activerecord'

require 'ruby-debug'

class User < ActiveRecord::Base
end

class App < Sinatra::Application

  set :public_folder, Proc.new { File.join(root, "public") }

  before do
    content_type :json
  end

  after do
    ActiveRecord::Base.connection.close
  end

  post '/users' do
    user = User.create(params)
    p user
  end

  get '/users' do
    p User.all.each.map{|user| {id: user.id, email: user.email}}.to_json
  end

  get '/users/:id' do
    user = User.find(params[:id])
    data = {id: user.id, email: user.email}.to_json
    p data
  end

end

App.run
