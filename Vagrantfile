# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "mongo" do |mongo|
  mongo.vm.box ="bento/ubuntu-16.04"
  #mongo.vm.network "forwarded_port", guest:27017, host:28018
  mongo.vm.hostname = "mongo"
  mongo.vm.network "private_network", ip: '192.168.50.51'
    mongo.vm.provision "chef_solo" do |chef|
      chef.add_recipe "mongo"
      chef.add_recipe "filebeat"
    end
  mongo.vm.provision "shell", inline: "mkdir -p /etc/filebeat; cp /vagrant/filebeat/mongo/filebeat.yml /etc/filebeat/filebeat.yml; chmod a+r /etc/filebeat/filebeat.yml"
  mongo.vm.provision "shell", inline: "cd /vagrant && chmod +x nagios/remote-setup-mongo.sh && ./nagios/remote-setup-mongo.sh"
  end

  config.vm.define "web_app" do |web_app|
    web_app.vm.box ="bento/ubuntu-14.04"
    #web_app.vm.network "forwarded_port", guest:8080, host:8080
    web_app.vm.hostname = "web-app"
    web_app.vm.network "private_network", ip: '192.168.50.50'
    web_app.vm.provision "chef_solo" do |chef|
      chef.add_recipe "web_app"
    end
    web_app.vm.provision "shell", inline: "cd /vagrant && chmod +x nagios/remote-setup-webapp.sh && ./nagios/remote-setup-webapp.sh"
  end

  config.vm.define 'nginx' do |nginx|
    nginx.vm.box = 'bento/ubuntu-16.04'
    nginx.vm.hostname = 'nginx'
    nginx.vm.network 'forwarded_port', guest: 80, host: 8008
    nginx.vm.network 'private_network', ip: '192.168.50.52'
    nginx.vm.provision 'chef_solo' do |chef|
      chef.roles_path = 'roles'
      chef.add_role('nginx')
      chef.add_recipe "filebeat"
    end
    nginx.vm.provision "shell", inline: "mkdir -p /etc/filebeat; cp /vagrant/filebeat/nginx/filebeat.yml /etc/filebeat/filebeat.yml; chmod a+r /etc/filebeat/filebeat.yml"
    nginx.vm.provision "shell", inline: "cd /vagrant && chmod +x nagios/remote-setup-nginx.sh && ./nagios/remote-setup-nginx.sh"
  end

  config.vm.define 'elk' do |elk|
    elk.vm.box = "apolloclark/elastic5x-ubuntu14"
    elk.vm.box_version = "20170831"
    elk.vm.hostname = "elk"
    elk.vm.network 'forwarded_port', guest: 5601, host: 5601
    elk.vm.network 'private_network', ip: "192.168.50.53"
    
  end

  config.vm.define "nagios" do |nagios|
    nagios.vm.box ="bento/ubuntu-16.04"
    #mongo.vm.network "forwarded_port", guest:80, host:8081
    nagios.vm.hostname = "nagios"
    nagios.vm.network "private_network", ip: '192.168.50.54'
    nagios.vm.provision "shell", inline: "cd /vagrant && chmod +x nagios/setup.sh && ./nagios/setup.sh"
  end
end
