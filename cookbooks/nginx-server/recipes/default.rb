# -*- mode: ruby -*-
# vi: set ft=ruby :

include_recipe "apache2"

web_app "localhost" do
  docroot "/var/www/html"
  cookbook 'apache2'
end

service 'nginx' do
  action [:enable, :start]
end

