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

    kill puma with:
      kill -s 9 \$(ps -ef | grep puma | head -n 1 | awk '{print \$2}')

    start puma with:
      cd /var/www/api-example
      bundle exec puma -e development -t 2:4 -w 2 --preload -d

    " > /etc/motd.tail
  EOF
end
