# -*- mode: ruby -*-
# vi: set ft=ruby :

apt_repository 'nginx' do
    uri          'http://nginx.org/packages/ubuntu/'
    distribution 'xenial'
    components   ['nginx']
    deb_src      true
end

apt_update

apt_package 'nginx'

service 'apache' do
    supports :status: true, :restart => true, :reload => true
    action :enable
end