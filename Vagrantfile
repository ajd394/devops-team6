# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "mongo", primary: true do |mongo|
  mongo.vm.box ="bento/ubuntu-14.04"
  mongo.vm.network "forwarded_port", guest:27017, host:28018
  mongo.vm.network "private_network", ip: '192.168.50.51'
    mongo.vm.provision "chef_solo" do |chef|
      chef.add_recipe "mongo"
    end
  end

  config.vm.define "web_app", primary: true do |web_app|
    web_app.vm.box ="bento/ubuntu-14.04"
    #web_app.vm.network "forwarded_port", guest:8080, host:8080
    web_app.vm.network "private_network", ip: '192.168.50.50'
    web_app.vm.provision "chef_solo" do |chef|
      chef.add_recipe "web_app"
    end
  end

  config.vm.define 'nginx' do |nginx| 
    nginx.vm.box = 'bento/ubuntu-16.04'
    nginx.vm.network 'forwarded_port', guest: 80, host: 8008
    nginx.vm.provision 'chef_solo' do |chef|
      chef.roles_path = 'roles'
      chef.add_role('nginx')
    end
  end
end
