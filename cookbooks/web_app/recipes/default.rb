# -*- mode: ruby -*-
# vi: set ft=ruby :

include_recipe 'nodejs'

remote_directory '/web_app' do
  source 'web_app'
  files_owner 'root'
  files_group 'root'
  files_mode '0750'
  action :create
  recursive true
end

execute 'npm install' do
  cwd '/web_app'
  command 'npm install'
end

template '/etc/init/webapp.conf' do
  source 'webapp.conf.erb'
  mode 0440
end

service 'webapp' do
  action :start
  provider Chef::Provider::Service::Upstart
end