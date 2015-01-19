#
# Cookbook Name:: nginx-app
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'nginx'

service 'nginx' do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end

template '/etc/nginx/sites-available/default' do
  source 'nginx.conf.erb'
  notifies :reload, 'service[nginx]'
end


