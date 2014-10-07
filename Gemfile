source 'https://rubygems.org'

gem 'bundler'
gem 'rake'

gem 'sinatra'
gem 'sinatra-contrib'
gem 'sinatra-activerecord'
gem 'activerecord', "3.2.19"
gem 'foreigner'
gem 'sqlite3'
gem 'mysql2'

gem 'puma'

gem 'knife-solo'
gem 'librarian-chef'
gem 'dotenv'
gem 'dotenv-deployment'

gem 'my_service', path: './client'

group :development, :test do
  gem 'debugger'
  gem 'shotgun' # Auto-reload sinatra app on change
end

group :test do
  gem 'rspec'
  gem 'rack-test'
  gem 'factory_girl'
  gem 'guard-rspec'
  gem 'faker'
  gem 'shoulda'
  gem 'database_cleaner'
  gem 'json_spec'
  gem 'webmock'
end
