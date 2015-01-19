#
# Cookbook Name:: api-example
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'libmysql++-dev'

bash 'install aglio' do
  code 'npm install -g aglio'
  # XXX: Usage:
  # aglio -i blueprint/hello.apib -o public/hello.html
end

# bash 'install protagonist' do
# #  user :vagrant
#   cwd '/tmp'
#   code <<-EOF
#   npm install -g node-gyp
#   git clone git://github.com/apiaryio/protagonist.git
#   cd protagonist
#   git submodule update --init --recursive
#   node-gyp configure
#   node-gyp build
#   npm install
#   EOF
# end

template 'bundlefix.sh' do
  source 'bundlefix.sh.erb'
  action :create
  path '/tmp/bundlefix.sh'
end

bash 'bundle install' do
  cwd '/var/www/sinatra-microservice'
  code 'su -c "/bin/bash /tmp/bundlefix.sh" vagrant'
end

bash 'kill puma' do
  only_if "ps -ef | grep puma | head -n 1 | grep -v 'grep' | awk '{print \$2}'"
  code "nohup kill -s 9 \$(ps -ef | grep puma | head -n 1 | awk \'{print \$2}\') &"
end

bash 'start puma' do
  cwd '/var/www/sinatra-microservice'
  code <<-EOF
echo "#!/bin/bash
if [ ! \\$RECALLED ]; then
  export RECALLED=foo
  source /etc/profile.d/rbenv.sh && . \\$0
  exit
fi
export RBENV_ROOT=\\$rbenv_root
\\$RBENV_ROOT/shims/bundle exec puma -w 4 -t 4:8 -e development -d -p9292
" > /tmp/start-puma
chmod +x /tmp/start-puma
su -c '/bin/bash /tmp/start-puma' vagrant
  EOF
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
      cd /var/www/sinatra-microservice
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
