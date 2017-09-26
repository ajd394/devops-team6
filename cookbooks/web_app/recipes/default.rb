# -*- mode: ruby -*-
# vi: set ft=ruby :

apt_repository 'nginx' do
    uri          'http://nginx.org/packages/ubuntu/'
    distribution 'xenial'
    components   ['nginx']
    deb_src      true
end

apt_update

apt_package 'nginx' do
    options '--allow-unauthenticated'
end

service 'nginx' do
    supports :status => true, :restart => true, :reload => true
    action :enable
end