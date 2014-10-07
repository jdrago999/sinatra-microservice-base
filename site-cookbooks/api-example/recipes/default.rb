#
# Cookbook Name:: api-example
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

ruby 'setup_var_www' do
  code '`mkdir -p /var/www && ln -s /vagrant /var/www/api-example`'
end

package 'libmysql++-dev' do
  action :install
end

bash 'bundle' do
  cwd '/var/www/api-example'
  code 'bundle'
end

bash 'add-motd' do
  not_if 'grep puma /etc/motd.tail'
  code <<-EOF
    echo "
          _        _  _  _  _   _  _  _
        _(_)_     (_)(_)(_)(_)_(_)(_)(_)
      _(_) (_)_   (_)        (_)  (_)
    _(_)     (_)_ (_) _  _  _(_)  (_)
   (_) _  _  _ (_)(_)(_)(_)(_)    (_)
   (_)(_)(_)(_)(_)(_)             (_)
   (_)         (_)(_)           _ (_) _
   (_)         (_)(_)          (_)(_)(_)

    Kill puma with:
      kill -s 9 \$(ps -ef | grep puma | head -n 1 | awk '{print \$2}')

    Start the service with:
      cd /var/www/api-example
      ruby app.rb -p9292

    In production:
      puma -w 4 -t 4:8 -e production -d -p9292

    Add a new ActiveRecord migration:
      rake db:create_migration NAME=<create_users>
      # creates db/migrate/20141007164537_create_users.rb
      # !! (only lower case letters, numbers, and '_' allowed in the name)

    Run Database Migrations:
      rake db:migrate

    Run Tests:
      bundle exec rspec

    " > /etc/motd.tail
  EOF
end
