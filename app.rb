require 'sinatra'
require 'sinatra/activerecord'
require 'ruby-debug'
require "sinatra/reloader" if development?

class User < ActiveRecord::Base
end

set :public_folder, Proc.new { File.join(root, "public") }

before do
  content_type :json
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
