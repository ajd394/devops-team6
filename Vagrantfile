# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.define 'nginx' do |nginx| 
    nginx.vm.box = 'bento/ubuntu-16.04'

    nginx.vm.provider :virtualbox do |vb|
      vb.memory = 4096
      vb.cpus = 2
    end

    nginx.vm.network 'forwarded_port', guest: 80, host: 8008

    nginx.vm.provision 'chef_solo' do |chef|
      chef.roles_path = 'roles'
      chef.add_role('nginx')
    end
  end
end
